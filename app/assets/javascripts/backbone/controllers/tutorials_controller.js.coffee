class CakeSide.Controllers.TutorialsController extends Marionette.Controller
  views: CakeSide.Views.Tutorials
  initialize: (options) ->
    @content_region = CakeSide.Application.content_region
    @tutorials = CakeSide.Application.request('TutorialsRepository')

  index: ->
    @content_region.show(new @views.IndexView(collection: @tutorials))
