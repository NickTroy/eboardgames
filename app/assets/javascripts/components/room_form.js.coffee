@RoomForm = React.createClass
  getInitialState: ->
    title: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '',  { room: @state }, (data) =>
      @props.handleNewRoom data
      @setState @getInitialState()
      'JSON'
  valid: ->
    @state.title
  render: ->
    React.DOM.form
      className: "form-inline"
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: "text"
          className: 'form-control'
          placeholder: 'Enter title...'
          name: 'title'
          value: @state.title
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'New room'