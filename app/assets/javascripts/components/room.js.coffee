@Room = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, 
        React.DOM.a 
          href: "/rooms/#{@props.room.id}"
          @props.room.title
      React.DOM.td null, @props.room.user_name