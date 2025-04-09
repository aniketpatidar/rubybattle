class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :start_battle, :submit_solution]
  before_action :ensure_room_access, only: [:show, :start_battle, :submit_solution]

  def show
    if @room.stale?
      @room.cancel_if_stale!
      flash[:alert] = "This room was not filled in time and has been cancelled."
      redirect_to challenges_path
      return
    end

    if @room.room_participants.count >= 2 && 
       !@room.is_participant?(current_user)
      flash[:alert] = "This room is already full."
      redirect_to challenges_path
      return
    end

    unless @room.is_participant?(current_user)
      @room.add_participant(current_user)
    end

    @challenge = @room.challenge
    @room.reset_player_ready
    @room.set_player_ready(current_user)
    @waiting_for_opponent = !@room.can_start_battle?
  end

  def start_battle
    if @room.start_battle!
      redirect_to room_path(@room.code), notice: 'Battle started!'
    else
      redirect_to room_path(@room.code), alert: 'Could not start battle'
    end
  end

  def submit_solution
    code = params.dig(:room, :code)
    method_template = params.dig(:room, :method_template) || @room.challenge.method_template

    if code.blank?
      return render json: { 
        success: false, 
        error: 'No code provided' 
      }, status: :unprocessable_entity
    end

    method_name_match = method_template.match(/def\s+(\w+)\s*\(/)
    if method_name_match.nil?
      return render json: { 
        success: false, 
        error: 'Invalid method template' 
      }, status: :unprocessable_entity
    end

    method_name = method_name_match[1]
    unless code.match?(/def\s+#{method_name}\s*\(/)
      return render json: { 
        success: false, 
        error: "Solution must define a method named '#{method_name}'" 
      }, status: :unprocessable_entity
    end

    submission_service = SubmissionService.new(@room.challenge, current_user, code)
    
    if submission_service.validate
      if @room.submit_solution!(current_user, code)
        render json: {
          success: true,
          test_results_html: render_to_string(
            partial: 'test_results', 
            locals: { room: @room }
          )
        }
      else
        render json: { 
          success: false, 
          error: 'Could not submit solution to room' 
        }, status: :unprocessable_entity
      end
    else
      render json: { 
        success: false, 
        error: 'Solution failed challenge tests' 
      }, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find_by!(code: params[:id] || params[:code])
  end

  def ensure_room_access
    unless @room.users.include?(current_user)
      flash[:error] = "You don't have access to this room"
      redirect_to home_index_path
    end
  end
end
