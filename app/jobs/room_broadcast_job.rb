class RoomBroadcastJob < ApplicationJob
  queue_as :default

  def perform(room)
    ActionCable.server.broadcast "rooms_channel", visitors_count: room.visitors_count, room_id: room.id
  end

end
