class CakeSide.Controllers.CakesController extends Marionette.Controller
  initialize: (options) ->
    @content_region = CakeSide.Application.content_region
    @cakes = CakeSide.Application.request('CakesRepository')
    @comment_view = CakeSide.Application.request('CommentView')

  index: ->
    @comment_view.hide()
    @content_region.show(new CakeSide.Views.Cakes.IndexView(collection: @cakes))

  show: (id) ->
    cake = @cakes.get(id)
    @content_region.show(new CakeSide.Views.Cakes.ShowView(model: cake))
    @comment_view.render
      identifier: "c-#{cake.id}"
      title: cake.get('name')
      url: cake.public_url()

  newCake: ->
    @comment_view.hide()
    @content_region.show(new CakeSide.Views.Cakes.NewView(collection: @cakes))

  edit: (id) ->
    @content_region.show(new CakeSide.Views.Cakes.EditView(model: @cakes.get(id)))
    @comment_view.hide()

