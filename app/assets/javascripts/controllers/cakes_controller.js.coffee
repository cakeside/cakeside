class CakeSide.Controllers.CakesController extends Marionette.Controller
  views: CakeSide.Views.Cakes
  initialize: (options) ->
    @content_region = CakeSide.Application.content_region
    @cakes = CakeSide.Application.request('CakesRepository')
    #@comment_view = CakeSide.Application.request('CommentView')

  index: ->
    @selectTab()
    #@comment_view.hide()
    @content_region.show(new @views.IndexView(collection: @cakes))

  show: (id, photo_id) ->
    @selectTab()
    cake = @cakes.get(id)
    @content_region.show(new @views.ShowView(model: cake, photo_id: photo_id))
    #@comment_view.render
      #identifier: "c-#{cake.id}"
      #title: cake.get('name')
      #url: cake.public_url()

  newCake: ->
    @selectTab()
    #@comment_view.hide()
    @content_region.show(new @views.NewView(collection: @cakes))

  edit: (id) ->
    @selectTab()
    @content_region.show(new @views.EditView(model: @cakes.get(id)))
    #@comment_view.hide()

  selectTab: ->
    $('.nav-link').removeClass('active')
    $('a[href="/my#cakes/new"]').addClass('active')
