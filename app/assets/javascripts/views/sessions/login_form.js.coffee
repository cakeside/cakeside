#= require views/auto_view

class CakeSide.Views.LoginForm extends CakeSide.AutoView
  @viewName 'login-form'
  events:
    'change #session_username': 'render'
    'change #session_password': 'render'

  render: ->
    @$('input[type=submit]').prop('disabled', !@valid())

  valid: ->
    !_.isEmpty(@field("username").val()) && !_.isEmpty(@field("password").val())

  modelKey: -> "session"
