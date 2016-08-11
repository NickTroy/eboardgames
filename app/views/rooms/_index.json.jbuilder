json.array! @rooms do |room|
  json.(room, :id, :title, :visitors_count)
  json.user_name room.user.email
end