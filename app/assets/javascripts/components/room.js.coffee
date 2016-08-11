@Room = React.createClass
  enterLinkClass: ->
    if @props.room.visitors_count == 2 
      "non-active" 
    else 
      ""
  render: ->
    React.DOM.tr null,
      React.DOM.td null, 
        React.DOM.a 
          href: "/rooms/#{@props.room.id}"
          className: @enterLinkClass()
          @props.room.title

      React.DOM.td null, @props.room.user_name 
      React.DOM.td null, @props.room.visitors_count
      React.DOM.td null,
        React.DOM.a
          className: "btn btn-danger"
          'Delete'

    