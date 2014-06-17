Cake.Views.Cakes ||= {}

class Cake.Views.ErrorView extends Backbone.View
  initialize: (options) ->
    @attributesWithErrors = @options.attributesWithErrors
    _.bindAll(@, "clearOldErrors", "renderErrors", "renderError", "fieldFor")

  render: () ->
    @clearOldErrors()
    @renderErrors()

  clearOldErrors: () ->
    @$(".error").removeClass("error")
    @$("p.inline-errors").remove()

  renderErrors: () ->
    _.each(@attributesWithErrors.errors, @renderError)

  renderError: (errors, attribute) ->
    errorString = errors.join(", ")
    field = @fieldFor(attribute)
    errorTag = $('<p>').addClass('inline-errors').text(errorString)
    field.append(errorTag)
    field.addClass("error")

  fieldFor: (attribute) ->
    @$("input[id*='_#{attribute}']").parent()
