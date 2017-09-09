#= require views/auto_view

class CakeSide.Views.RegistrationForm extends CakeSide.AutoView
  @viewName 'registration-form'
  modelKey: "user"
  events:
    'input #user_name': 'onInput'
    'input #user_email': 'onInput'
    'input #user_password': 'onInput'
    'change #user_accepted': 'onInput'
    'submit form': 'onSubmit'

  initialize: () ->
    @model = new CakeSide.Models.User()

  render: ->
    @renderErrors(@model.validationError)

  onInput: (event) ->
    $element = $(event.target)
    @model.set(@fieldNameFor($element), @valueFor($element))
    @$('input[type=submit]').prop('disabled', !@model.isValid())
    @render()

  onSubmit: (event) ->
    if !@model.isValid()
      @$('input[type=submit]').prop('disabled', true)
      event.preventDefault()
      event.stopPropagation()
    @render()

  valueFor: (element) ->
    if element.is(':checkbox')
      element.prop('checked')
    else
      element.val()
