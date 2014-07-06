class CakeSide.Routers.PhotosRouter extends Backbone.Router
  routes:
    "cakes/:cake_id/photos/:id"      : "show"

  show: (cake_id, id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    photo = new CakeSide.Models.Photo({cake_id: cake_id, id: id})
    photo.fetch()
    cake = CakeSide.Application.request('CakesRepository').get(cake_id)
    @view = new CakeSide.Views.Photos.ShowView(model: photo, collection: @photos)
    CakeSide.Application.content_region.show(@view)
    CakeSide.Application.request('CommentView').render
      identifier: "c-#{cake_id}"
      title: cake.get('name')
      url: cake.public_url()
