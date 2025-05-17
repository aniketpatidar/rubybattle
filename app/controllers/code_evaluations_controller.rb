class CodeEvaluationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def evaluate
    render json: { output: evaluate_code(params[:code], Challenge.find(params[:id]).tests) }
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def evaluate_code(code, tests)
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
            actual: e.message,
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
