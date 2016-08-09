json.array! @rooms do |room|
  json.id room.id
  json.title room.title
  json.user_name room.user.email
end