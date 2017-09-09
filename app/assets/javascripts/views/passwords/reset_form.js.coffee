class csx.Views.PasswordResetForm extends csx.AutoView
  @viewName 'password-reset-form'
  modelKey: "user"
  events:
    'input #user_email': 'onInput'
    'submit form': 'onSubmit'

  initialize: () ->
    @model = new csx.Models.PasswordReset()

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
