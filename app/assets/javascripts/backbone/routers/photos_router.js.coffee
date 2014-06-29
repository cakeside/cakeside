class CakeSide.Routers.PhotosRouter extends Backbone.Router
  routes:
    "cakes/:cake_id/photos/new"      : "newPhoto"
    "cakes/:cake_id/photos/index"    : "index"
    "cakes/:cake_id/photos/:id/edit" : "edit"
    "cakes/:cake_id/photos/:id"      : "show"
    "cakes/:cake_id/photos/.*"        : "index"

  newPhoto: (cake_id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    @view = new CakeSide.Views.Photos.NewView(collection: @photos)
    $("#backbone-content").html(@view.render().el)

  index: (cake_id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    @view = new CakeSide.Views.Photos.IndexView(photos: @photos)
    $("#backbone-content").html(@view.render().el)

  show: (cake_id, id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    photo = new CakeSide.Models.Photo({cake_id: cake_id, id: id})
    photo.fetch()
    @view = new CakeSide.Views.Photos.ShowView(model: photo, collection: @photos)
    $("#backbone-content").html(@view.render().el)

  edit: (cake_id, id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    @view = new CakeSide.Views.Photos.EditView(model: @photos.get(id))
    $("#backbone-content").html(@view.render().el)
