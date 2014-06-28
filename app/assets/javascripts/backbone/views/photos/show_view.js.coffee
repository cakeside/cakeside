CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.ShowView extends Backbone.View
  template: JST["backbone/templates/photos/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
