class CodeEvaluationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def evaluate
    challenge = Challenge.find(params[:id])
    result = CodeEvaluation.run(
      user: current_user,
      challenge: challenge,
      code: params[:code],
      duel_id: params[:duel_id]
    )
    render json: { output: result.test_results }
  rescue KeyError
    render json: { error: "JUDGE0_API_KEY is not configured." }, status: :service_unavailable
  rescue => e
    Rails.logger.error("Code evaluation failed: #{e.message}")
    render json: { error: "Code evaluation failed. Please try again." }, status: :internal_server_error
  end
end
