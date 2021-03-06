$(document).on 'turbolinks:load', ->

  if $('#messages').length > 0
    App.unsubscribe_from_main()
    messages = $('#messages')
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
    messages_to_bottom()

    room_id = $('#messages').data('room-id')
    subscriptions = App.cable.subscriptions
    if subscriptions.findAll('{"channel":"RoomChannel","room_id":' + room_id + '}').length == 0 
      App.room = subscriptions.create {
        channel: "RoomChannel", 
        room_id: room_id 
        main_page: false
      },
      connected: ->
        #alert("connected")
      disconnected: ->
        #alert("disconnected")
      received: (data) ->
        $('#messages').append data['message']
        messages_to_bottom()
        # Called when there's incoming data on the websocket for this channel
      speak: (message, room_id) ->
        @perform 'speak', message: message, room_id: room_id
  
  pathname = window.location.pathname
  if pathname == '/rooms'
    App.unsubscribe_from_room()       

    subscriptions = App.cable.subscriptions

    App.main = subscriptions.create {
      channel: "RoomChannel", 
      room_id: undefined 
      main_page: true
    },
    connected: ->
      #alert("connected to main channel")
    disconnected: ->
      #alert("disconnected from main channel")
    received: (data) ->
      visitors_count = data.visitors_count
      room_id = data.room_id
      App.updateVisitorsCount(room_id, visitors_count)
 
$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  room_id = $('#messages').data('room-id')
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value, room_id
    event.target.value = ""
    event.preventDefault()
App.unsubscribe_from_room = ->
  pathname = window.location.pathname

  if pathname == '/rooms' and App.room
    App.room.unsubscribe()
    delete App.room
App.unsubscribe_from_main = ->
  pathname = window.location.pathname

  if pathname != '/rooms' and App.main
    App.main.unsubscribe()
    delete App.main







