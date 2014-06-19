class Cake.Routers.PhotosRouter extends Backbone.Router
  routes:
    "cakes/:cake_id/photos/new"      : "newPhoto"
    "cakes/:cake_id/photos/index"    : "index"
    "cakes/:cake_id/photos/:id/edit" : "edit"
    "cakes/:cake_id/photos/:id"      : "show"
    "cakes/:cake_id/photos/.*"        : "index"

  newPhoto: (cake_id) ->
    @photos = new Cake.Collections.PhotosCollection(cake_id: cake_id)
    @view = new Cake.Views.Photos.NewView(collection: @photos)
    $("#backbone-content").html(@view.render().el)

  index: (cake_id) ->
    @photos = new Cake.Collections.PhotosCollection(cake_id: cake_id)
    @view = new Cake.Views.Photos.IndexView(photos: @photos)
    $("#backbone-content").html(@view.render().el)

  show: (cake_id, id) ->
    photo = @photos.get(id)

    @view = new Cake.Views.Photos.ShowView(model: photo)
    $("#backbone-content").html(@view.render().el)

  edit: (cake_id, id) ->
    photo = @photos.get(id)

    @view = new Cake.Views.Photos.EditView(model: photo)
    $("#backbone-content").html(@view.render().el)
