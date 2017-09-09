#= require views/auto_view

class csx.Views.LoginForm extends csx.AutoView
  @viewName 'login-form'
  modelKey: "session"
  events:
    'input #session_email': 'onInput'
    'input #session_password': 'onInput'
    'submit form': 'onSubmit'

  initialize: () ->
    @model = new csx.Models.Session()

  render: ->
    @renderErrors(@model.validationError)

  onInput: (event) ->
    $element = $(event.target)
    @model.set(@fieldNameFor($element), $element.val())
    @$('input[type=submit]').prop('disabled', !@model.isValid())
    @render()

  onSubmit: (event) ->
    if !@model.isValid()
      @$('input[type=submit]').prop('disabled', true)
      event.preventDefault()
      event.stopPropagation()
    @render()
