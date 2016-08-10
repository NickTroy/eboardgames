class AddColumnVisitorsCountToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :visitors_count, :integer, default: 0
  end
end
