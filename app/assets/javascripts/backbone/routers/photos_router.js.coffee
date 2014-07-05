class CakeSide.Routers.PhotosRouter extends Backbone.Router
  routes:
    "cakes/:cake_id/photos/new"      : "newPhoto"
    "cakes/:cake_id/photos/:id"      : "show"

  newPhoto: (cake_id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    @view = new CakeSide.Views.Photos.NewView(collection: @photos)
    $("#backbone-content").html(@view.render().el)

  show: (cake_id, id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    photo = new CakeSide.Models.Photo({cake_id: cake_id, id: id})
    photo.fetch()
    cake = CakeSide.Application.request('CakesRepository').get(cake_id)
    @view = new CakeSide.Views.Photos.ShowView(model: photo, collection: @photos)
    CakeSide.Application.request('CommentView').render
      identifier: "c-#{cake_id}"
      title: cake.get('name')
      url: cake.public_url()
    $("#backbone-content").html(@view.render().el)