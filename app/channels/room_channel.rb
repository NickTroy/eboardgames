class RoomChannel < ApplicationCable::Channel
  def subscribed
    main_page = params['main_page']
    room_id = params['room_id']
    if main_page
      stream_from "rooms_channel"
    else
      stream_from "rooms_#{room_id}_channel"
      room = Room.find(room_id)
      current_visitors_count = room.visitors_count 
      room.update_attributes(visitors_count: current_visitors_count + 1)
    end
  end
 
  def unsubscribed
    main_page = params['main_page']
    room_id = params['room_id']
    unless main_page
      room = Room.find(room_id)
      current_visitors_count = room.visitors_count 
      room.update_attributes(visitors_count: current_visitors_count - 1)
    end
  end
 
  def speak(data)
    current_user.messages.create!(body: data['message'], room_id: data['room_id'])
  end
end