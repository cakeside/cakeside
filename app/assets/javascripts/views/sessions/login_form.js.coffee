#= require views/auto_view

class CakeSide.Views.LoginForm extends CakeSide.AutoView
  @viewName 'login-form'
  modelKey: "session"
  events:
    'keyup #session_username': 'onKeyUp'
    'keyup #session_password': 'onKeyUp'
    'submit form': 'onSubmit'


  initialize: () ->
    @model = new CakeSide.Models.Session()

  render: ->
    @renderErrors(@model.validationError)

  onKeyUp: (event) ->
    @model.set('username', @field('username').val())
    @model.set('password', @field('password').val())
    @$('input[type=submit]').prop('disabled', !@model.isValid())
    @render()

  onSubmit: (event) ->
    if !@model.isValid()
      @$('input[type=submit]').prop('disabled', true)
      event.preventDefault()
      event.stopPropagation()
    @render()

  renderErrors: (errors) ->
    @hideErrors()
    _.each _.keys(errors), (key) =>
      @showError(@field(key), errors[key])
