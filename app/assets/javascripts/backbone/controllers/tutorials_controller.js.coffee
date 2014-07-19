class CakeSide.Controllers.TutorialsController extends Marionette.Controller
  views: CakeSide.Views.Tutorials
  initialize: (options) ->
    @content_region = CakeSide.Application.content_region
    @tutorials = CakeSide.Application.request('TutorialsRepository')
    @comment_view = CakeSide.Application.request('CommentView')

  index: ->
    @comment_view.hide()
    @content_region.show(new @views.IndexView(collection: @tutorials))

  new: ->
    @comment_view.hide()
    @content_region.show(new @views.NewView(collection: @tutorials))
