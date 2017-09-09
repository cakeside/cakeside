#= require ./auto_view

class csx.FormView extends csx.AutoView
  hideErrors: () ->
    @$(':input').removeClass('is-invalid')
    @$('.invalid-feedback').html('')

  showError: (field, message) ->
    @$(field).addClass('is-invalid').siblings('.invalid-feedback').html(message)

  renderErrors: (errors) ->
    @hideErrors()
    _.each _.keys(errors), (key) =>
      @showError(@field(key), errors[key])

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

  field: (name) -> @$("##{@fieldName(name)}")
  fieldName: (name) -> "#{@modelKey}_#{name}"
  fieldNameFor: (element) -> element.attr('id').replace("#{@modelKey}_", '')
