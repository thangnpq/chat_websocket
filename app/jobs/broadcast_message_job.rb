class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", {
      email: message.user.email,
      content: message.content,
      chatroom_id: message.chatroom.id
    }
  end
end
