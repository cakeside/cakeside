class csx.Controllers.My.TutorialsController extends Marionette.Controller
  views: csx.Views.My.Tutorials
  initialize: (options) ->
    @content_region = csx.Application.content_region
    @tutorials = csx.Collections.Tutorial

  index: ->
    @selectTab()
    @content_region.show(new @views.IndexView(collection: @tutorials))

  new: ->
    @selectTab()
    @content_region.show(new @views.NewView(collection: @tutorials))

  show: (id) ->
    @selectTab()
    tutorial = @tutorials.get(id)
    @content_region.show(new @views.ShowView(model: tutorial))

  selectTab: ->
    $('.nav-link').removeClass('active')
    $('a[href="/my#tutorials/new"]').addClass('active')
