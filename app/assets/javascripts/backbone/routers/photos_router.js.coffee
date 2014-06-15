class Cake.Routers.PhotosRouter extends Backbone.Router
  initialize: (options) ->
    @photos = new Cake.Collections.PhotosCollection()
    @photos.reset options.photos

  routes:
    "new"      : "newPhoto"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newPhoto: ->
    @view = new Cake.Views.Photos.NewView(collection: @photos)
    $("#photos").html(@view.render().el)

  index: ->
    @view = new Cake.Views.Photos.IndexView(photos: @photos)
    $("#photos").html(@view.render().el)

  show: (id) ->
    photo = @photos.get(id)

    @view = new Cake.Views.Photos.ShowView(model: photo)
    $("#photos").html(@view.render().el)

  edit: (id) ->
    photo = @photos.get(id)

    @view = new Cake.Views.Photos.EditView(model: photo)
    $("#photos").html(@view.render().el)
