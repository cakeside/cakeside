Cake.Views.Cakes ||= {}

class Cake.Views.Cakes.EditView extends Backbone.View
  template : JST["backbone/templates/cakes/edit"]

  events :
    "submit #edit-cake" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (cake) =>
        @model = cake
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
