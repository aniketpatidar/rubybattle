class RubyExecutionController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    code = params[:code]
    result = execute_ruby_code(code)
    render json: { output: result }
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def execute_ruby_code(code)
    original_stdout = $stdout
    $stdout = StringIO.new
    eval(code)
    $stdout.string
  ensure
    $stdout = original_stdout
  end
end