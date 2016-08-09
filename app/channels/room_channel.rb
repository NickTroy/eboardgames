class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rooms_#{params['room_id']}_channel"
  end
 
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
 
  def speak(data)
    current_user.messages.create!(body: data['message'], room_id: data['room_id'])
  end
end