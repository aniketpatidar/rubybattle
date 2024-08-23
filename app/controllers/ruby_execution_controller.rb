class RubyExecutionController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    code = params[:code]
    challenge = Challenge.find(params[:id])
    tests = challenge.tests

    render json: { output: execute_ruby_code(code, tests) }
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def execute_ruby_code(code, tests)
    results = {}

    begin
      eval(code)
      tests.each do |input, expected_output|
        begin
          actual_output = eval(input) 
          results[input] = {
            expected: expected_output,
            actual: actual_output,
            passed: actual_output == expected_output
          }
        rescue => e
          results[input] = {
            expected: expected_output,
            actual: "#{e.message}",
            passed: false
          }
        end
      end
    rescue => e
      return { error: e.message }
    end

    results
  end
end
