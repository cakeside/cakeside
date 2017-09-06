#= require views/auto_view

class CakeSide.Views.LoginForm extends CakeSide.AutoView
  @viewName 'login-form'
  modelKey: "session"
  events:
    'keyup #session_username': 'onKeyUp'
    'keyup #session_password': 'onKeyUp'
    'submit form': 'onSubmit'

  render: ->
    @hideErrors()
    @$('input[type=submit]').prop('disabled', !@isValid())
    _.each _.keys(@errors), (key) =>
      @showError(@field(key), @errors[key])

  isValid: ->
    _.keys(@errors).length == 0

  validate: ->
    @errors = {}
    if _.isEmpty(@field("username").val())
      @errors['username'] = "Email is required"

    if _.isEmpty(@field("password").val())
      @errors['password'] = "Password is required"

  onKeyUp: (event) ->
    @validate()
    @render()

  onSubmit: (event) ->
    @validate()
    if !@isValid()
      event.preventDefault()
      event.stopPropagation()
    @render()
