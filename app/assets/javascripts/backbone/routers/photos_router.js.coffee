class Cake.Routers.PhotosRouter extends Backbone.Router
  routes:
    "cakes/:cake_id/photos/new"      : "newPhoto"
    "photos/index"    : "index"
    "photos/:id/edit" : "edit"
    "photos/:id"      : "show"
    "photos/.*"        : "index"

  newPhoto: (cake_id) ->
    @photos = new Cake.Collections.PhotosCollection(cake_id: cake_id)
    @view = new Cake.Views.Photos.NewView(collection: @photos)
    $("#backbone-content").html(@view.render().el)

  index: ->
    @view = new Cake.Views.Photos.IndexView(photos: @photos)
    $("#backbone-content").html(@view.render().el)

  show: (id) ->
    photo = @photos.get(id)

    @view = new Cake.Views.Photos.ShowView(model: photo)
    $("#backbone-content").html(@view.render().el)

  edit: (id) ->
    photo = @photos.get(id)

    @view = new Cake.Views.Photos.EditView(model: photo)
    $("#backbone-content").html(@view.render().el)
