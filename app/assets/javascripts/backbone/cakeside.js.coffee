#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.CakeSide =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  initialize: (data) ->
    $(document).ajaxSend  (event, xhr) ->
      if data.access_token
        xhr.setRequestHeader "Authorization", "Token token=#{data.access_token}"

    CakeSide.Application = new Marionette.Application()
    CakeSide.Application.addInitializer (options) ->
      new CakeSide.Routers.CakesRouter()
      new CakeSide.Routers.PhotosRouter()

    CakeSide.Application.on 'start', ->
      if Backbone.history
        Backbone.history.start()

    @cakes = new CakeSide.Collections.CakesCollection()
    @categories = new CakeSide.Collections.CategoriesCollection()
    @categories.fetch(reset: true)

    CakeSide.Application.reqres.setHandler 'CakesRepository', =>
      @cakes
    CakeSide.Application.reqres.setHandler 'CategoriesRepository', =>
      @categories
    @photos_cache = {}
    CakeSide.Application.reqres.setHandler 'PhotosRepository', (cake_id) =>
      if @photos_cache[cake_id]
        @photos_cache[cake_id]
      else
        photos = new CakeSide.Collections.PhotosCollection(cake_id: cake_id)
        @photos_cache[cake_id] = photos
        photos.fetch(reset: true).done ->
          console.log('done fetching.')
        photos

    @cakes.fetch(reset: true).done ->
      CakeSide.Application.start()
