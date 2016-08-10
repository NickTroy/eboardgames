class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  after_update_commit { RoomBroadcastJob.perform_later(self) }
end
