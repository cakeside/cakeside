CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.PhotoView extends Backbone.View
  template: JST["backbone/templates/photos/photo"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
