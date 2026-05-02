class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i[show accept decline broadcast_code round_won]

  def new
    @friends = current_user.friends
  end

  def create
    @opponent  = User.find(params[:opponent_id])
    rc_key     = params[:round_count].to_s
    difficulty = params[:difficulty].to_s
    actual_count = Game::ROUND_COUNT_NUM[rc_key] || 1

    return redirect_to root_path, alert: "You can only challenge friends." unless current_user.friend_with?(@opponent)

    challenges = Challenge.where(difficulty: difficulty).order("RANDOM()").limit(actual_count)
    if challenges.size < actual_count
      @friends = current_user.friends
      flash.now[:alert] = "Not enough #{difficulty} challenges available."
      return render :new, status: :unprocessable_entity
    end

    @game = Game.create!(
      challenger:  current_user,
      opponent:    @opponent,
      round_count: rc_key,
      difficulty:  difficulty
    )

    challenges.each_with_index do |challenge, i|
      @game.game_rounds.create!(challenge: challenge, round_number: i + 1)
    end

    GameInviteNotification.create!(
      user:   @opponent,
      params: { game_id: @game.id, challenger_name: current_user.full_name, round_count: actual_count }
    )

    redirect_to game_path(@game), notice: "Challenge sent to #{@opponent.first_name}!"
  end

  def show
    return redirect_to root_path unless @game.participant?(current_user)
    @current_round = @game.game_rounds.ordered.find { |r| r.round_winner_id.nil? }
    @rounds        = @game.game_rounds.ordered.includes(:challenge, :round_winner)
  end

  def accept
    return redirect_to game_path(@game) unless @game.opponent == current_user && @game.pending?
    @game.update!(status: :active, started_at: Time.current)
    ActionCable.server.broadcast("game_#{@game.id}", { type: "game_started" })
    redirect_to game_path(@game)
  end

  def decline
    return redirect_to root_path unless @game.opponent == current_user && @game.pending?
    ActionCable.server.broadcast("game_#{@game.id}", { type: "game_declined" })
    @game.destroy
    redirect_to root_path, notice: "Game declined."
  end

  def broadcast_code
    return head :forbidden unless @game.active? && @game.participant?(current_user)
    ActionCable.server.broadcast("game_#{@game.id}", {
      type: "code_update", code: params[:code], user_id: current_user.id
    })
    head :ok
  end

  def round_won
    return head :forbidden unless @game.active? && @game.participant?(current_user)

    round = @game.game_rounds.find_by(id: params[:round_id])
    return head :not_found unless round
    return head :ok        if round.completed_at.present?

    if @game.challenger == current_user
      round.update_column(:challenger_code, params[:code])
    else
      round.update_column(:opponent_code, params[:code])
    end

    round.complete!(winner: current_user)
    @game.reload

    if @game.completed?
      [ @game.challenger, @game.opponent ].each do |player|
        opp = player == @game.challenger ? @game.opponent : @game.challenger
        GameResultNotification.create!(
          user:   player,
          params: { game_id: @game.id, winner_id: @game.winner_id, opponent_name: opp.full_name }
        )
      end
      ActionCable.server.broadcast("game_#{@game.id}", {
        type:        "game_completed",
        winner_id:   @game.winner_id,
        winner_name: @game.winner.full_name
      })
    else
      next_round = @game.game_rounds.ordered.find { |r| r.round_winner_id.nil? }
      ActionCable.server.broadcast("game_#{@game.id}", {
        type:              "round_completed",
        round_number:      round.round_number,
        winner_id:         current_user.id,
        winner_name:       current_user.full_name,
        next_round_number: next_round&.round_number
      })
    end

    head :ok
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
