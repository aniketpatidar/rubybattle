require 'uri'
require 'json'
require 'net/http'

class SubmissionService
  JUDGE0_API_URL = 'https://judge0-ce.p.rapidapi.com/submissions'
  RAPID_API_KEY = ENV['RAPID_API_KEY']
  RAPID_API_HOST = 'judge0-ce.p.rapidapi.com'
  MAX_RETRIES = 3
  RETRY_DELAY = 2

  def initialize(challenge, user, code)
    @challenge = challenge
    @user = user
    @code = code
  end

  def validate
    payload = {
      source_code: prepare_submission_code,
      language_id: ruby_language_id,
      stdin: @challenge.tests.keys.join("\n"),
      expected_output: @challenge.tests.values.join("\n")
    }

    submission_response = submit_to_judge0(payload)
    
    if submission_response['message']
      Rails.logger.error "Submission error: #{submission_response['message']}"
      return false
    end

    process_submission_result(submission_response)
  end

  private

  def submit_to_judge0(payload, retries = 0)
    uri = URI.parse(JUDGE0_API_URL)
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, {
      'Content-Type' => 'application/json',
      'X-RapidAPI-Key' => RAPID_API_KEY,
      'X-RapidAPI-Host' => RAPID_API_HOST
    })
    
    request.body = payload.to_json

    response = http.request(request)
    result = JSON.parse(response.body)

    if result['message'] == 'Too many requests' && retries < MAX_RETRIES
      Rails.logger.warn "Rate limit hit. Retry #{retries + 1}"
      sleep(RETRY_DELAY * (retries + 1))
      return submit_to_judge0(payload, retries + 1)
    end

    result
  rescue JSON::ParserError, StandardError => e
    Rails.logger.error "Submission error: #{e.message}"
    { 'message' => e.message }
  end

  def process_submission_result(submission_response, retries = 0)
    token = submission_response['token']
    
    result = fetch_submission_result(token)

    Rails.logger.error "Submission result: #{result.inspect}"

    if result.nil? || result['message']
      Rails.logger.error "Submission result error: #{result&.dig('message') || 'Unknown error'}"
      return false
    end

    if result['compile_output'].present?
      Rails.logger.error "Compilation error: #{result['compile_output']}"
      return false
    end

    if result['stderr'].present?
      Rails.logger.error "Runtime error: #{result['stderr']}"
      return false
    end

    stdout = result['stdout']
    if stdout.nil?
      Rails.logger.error "No stdout in submission result"
      return false
    end

    test_passed = stdout.split("\n").all? { |line| line.strip == 'true' }

    log_submission(test_passed, result)

    test_passed
  end

  def fetch_submission_result(token, retries = 0)
    uri = URI.parse("#{JUDGE0_API_URL}/#{token}")
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.path, {
      'X-RapidAPI-Key' => RAPID_API_KEY,
      'X-RapidAPI-Host' => RAPID_API_HOST
    })

    response = http.request(request)
    result = JSON.parse(response.body)

    if (result['message'] == 'Too many requests' || result['status']['id'] <= 2) && 
       retries < MAX_RETRIES
      Rails.logger.warn "Rate limit or pending status. Retry #{retries + 1}"
      sleep(RETRY_DELAY * (retries + 1))
      return fetch_submission_result(token, retries + 1)
    end

    Rails.logger.error "Fetch submission result response: #{response.body}"
    
    result
  rescue JSON::ParserError, StandardError => e
    Rails.logger.error "Error fetching submission result: #{e.message}"
    { 'message' => e.message }
  end

  def log_submission(test_passed, result)
    Submission.create!(
      challenge: @challenge,
      user: @user,
      passed_tests: test_passed,
      raw_result: result.to_json
    )
  end

  def ruby_language_id
    72
  end

  def prepare_submission_code
    <<~RUBY
    def #{@challenge.method_name}(number)
      #{@code}
    end

    #{generate_test_runner}
    RUBY
  end

  def generate_test_runner
    @challenge.tests.map do |input, expected_output|
      "puts #{@challenge.method_name}(#{input}) == #{expected_output}"
    end.join("\n")
  end
end
