class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]

  def index
    @discussions = Discussion.order(updated_at: :desc)
  end

  def show
    @posts = @discussion.posts.all.order(created_at: :asc)
    @new_post = @discussion.posts.new
  end

  def new
    @discussion = Discussion.new
    @discussion.posts.new
  end

  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: "Discussion created" }
      else
        flash[:error] = format_error_messages(@discussion.errors)
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        @discussion.broadcast_replace(partial: "discussions/header", locals: { discussion: @discussion })
        format.html { redirect_to @discussion, notice: "Discussion updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discussion.destroy!
    redirect_to discussions_path, notice: 'Discussion removed'
  end

  private

  def discussion_params
    params.require(:discussion).permit(:name, :description, :closed, :pinned, posts_attributes: :body)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def format_error_messages(errors)
    errors.map { |error| error.options[:message] }.join(", ")
  end
end
