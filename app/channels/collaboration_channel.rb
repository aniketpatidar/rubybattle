class CollaborationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "collaboration_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("collaboration_#{params[:room]}", data)
  end
end
