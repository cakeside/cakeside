Cake.Views.Cakes ||= {}

class Cake.Views.Cakes.CakeView extends Backbone.View
  template: JST["backbone/templates/cakes/cake"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this
