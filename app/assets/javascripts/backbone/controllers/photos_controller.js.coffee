class CakeSide.Controllers.PhotosController extends Marionette.Controller
  initialize: (options) ->
    @cakes = CakeSide.Application.request('CakesRepository')

  show: (cake_id, id) ->
    @photos = CakeSide.Application.request('PhotosRepository', cake_id)
    photo = new CakeSide.Models.Photo({cake_id: cake_id, id: id})
    photo.fetch()
    @view = new CakeSide.Views.Photos.ShowView(model: photo, collection: @photos)
    CakeSide.Application.content_region.show(@view)
    cake = @cakes.get(cake_id)
    CakeSide.Application.request('CommentView').render
      identifier: "c-#{cake_id}"
      title: cake.get('name')
      url: cake.public_url()

