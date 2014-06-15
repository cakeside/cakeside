Cake.Views.Cakes ||= {}

class Cake.Views.Cakes.ShowView extends Backbone.View
  template: JST["backbone/templates/cakes/show"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this
