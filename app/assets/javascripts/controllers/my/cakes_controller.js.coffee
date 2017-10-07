class csx.Controllers.My.CakesController extends Marionette.Controller
  views: csx.Views.My.Cakes
  initialize: (options) ->
    @content_region = csx.Application.content_region
    @cakes = csx.Collections.Creation

  index: ->
    @selectTab()
    @content_region.show(new @views.IndexView(collection: @cakes))

  show: (id, photo_id) ->
    @selectTab()
    cake = @cakes.get(id)
    @content_region.show(new @views.ShowView(model: cake, photo_id: photo_id))

  newCake: ->
    @selectTab()
    @content_region.show(new @views.NewView(collection: @cakes))

  edit: (id) ->
    @selectTab()
    @content_region.show(new @views.EditView(model: @cakes.get(id)))

  selectTab: ->
    $('.nav-link').removeClass('active')
    $('a[href="/my#cakes/new"]').addClass('active')
