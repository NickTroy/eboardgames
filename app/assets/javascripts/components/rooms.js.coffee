@Rooms = React.createClass
  getInitialState: ->
    rooms: JSON.parse(@props.data)
  getDefaultProps: ->
    rooms: []
  addRoom: (room) ->
    rooms = @state.rooms.slice()
    rooms.push room
    @setState rooms: rooms
  render: ->
    React.DOM.div
      className: 'rooms'
      React.DOM.h1
        className: 'title'
        'Rooms'
      React.createElement RoomForm, handleNewRoom: @addRoom
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'User'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for room in @state.rooms
            React.createElement Room, key: room.id, room: room