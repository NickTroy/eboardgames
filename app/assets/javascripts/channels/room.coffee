$(document).on 'turbolinks:load', ->

  if $('#messages').length > 0
    messages = $('#messages')
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
    messages_to_bottom()

    room_id = $('#messages').data('room-id')
    subscriptions = App.cable.subscriptions
    if subscriptions.findAll('{"channel":"RoomChannel","room_id":' + room_id + '}').length == 0 
      App.room = subscriptions.create {
        channel: "RoomChannel", 
        room_id: room_id 
      },
      connected: ->
        # Called when the subscription is ready for use on the server
      disconnected: ->
        # Called when the subscription has been terminated by the server
      received: (data) ->
        $('#messages').append data['message']
        messages_to_bottom()
        # Called when there's incoming data on the websocket for this channel
      speak: (message, room_id) ->
        @perform 'speak', message: message, room_id: room_id
    else
      App.room = subscriptions.findAll('{"channel":"RoomChannel","room_id":' + room_id + '}')[0]
      App.room.received = (data) ->
        $('#messages').append data['message']
        messages_to_bottom()        
      App.room.speak = (message, room_id) ->
        @perform 'speak', message: message, room_id: room_id
      App.unsubscribe_if_index = ->
        pathname = window.location.pathname

        if pathname == '/rooms'
          console.log App.room
          App.room.unsubscribe()
          console.log App.room  
      App.unsubscribe_if_index()   
    
 
$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  room_id = $('#messages').data('room-id')
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value, room_id
    event.target.value = ""
    event.preventDefault()
$(document).on 'click', '.leave_room_page', ->
  App.room.unsubscribe()






