Cake.Views.Photos ||= {}

class Cake.Views.Photos.IndexView extends Backbone.View
  template: JST["backbone/templates/photos/index"]

  initialize: () ->
    @options.photos.bind('reset', @addAll)

  addAll: () =>
    @options.photos.each(@addOne)

  addOne: (photo) =>
    view = new Cake.Views.Photos.PhotoView({model : photo})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(photos: @options.photos.toJSON() ))
    @addAll()

    return this
