#= require_self
#= require_tree ./initializers
#= require_tree ./lib
#= require_tree ./templates
#= require_tree ./models
#= require ./views
#= require_tree ./controllers
#= require_tree ./routers
#= require_tree ./service

window.csx =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Controllers: { My: {} }
  initialize: (data) ->
    $(document).ajaxSend  (event, xhr) ->
      if data.access_token
        xhr.setRequestHeader "Authorization", "Token token=#{data.access_token}"

    csx.Application = new Marionette.Application()
    csx.Application.addRegions
      content_region: '#backbone-content'

    csx.Application.addInitializer (options) ->
      new csx.Routers.CakesRouter
        controller: new csx.Controllers.My.CakesController()
      new csx.Routers.TutorialsRouter
        controller: new csx.Controllers.My.TutorialsController()
      new csx.Routers.DashboardRouter
        controller: new csx.Controllers.My.DashboardController()
      new csx.Routers.ProfileRouter
        controller: new csx.Controllers.My.ProfileController()

    csx.Application.on 'start', ->
      if Backbone.history
        Backbone.history.start()

    @cakes = new csx.Collections.CakesCollection()
    @categories = new csx.Collections.CategoriesCollection()
    @tutorials = new csx.Collections.TutorialsCollection()

    csx.Application.reqres.setHandler 'CakesRepository', =>
      @cakes
    csx.Application.reqres.setHandler 'CategoriesRepository', =>
      @categories
    @photos_cache = {}
    csx.Application.reqres.setHandler 'PhotosRepository', (cake_id) =>
      if @photos_cache[cake_id]
        @photos_cache[cake_id]
      else
        photos = new csx.Collections.PhotosCollection(cake_id: cake_id)
        @photos_cache[cake_id] = photos
        photos.fetch(reset: true)
        photos
    csx.Application.reqres.setHandler 'TutorialsRepository', =>
      @tutorials
    csx.Application.reqres.setHandler 'ProfilesRepository', =>
      @profiles ||= new csx.Collections.ProfilesCollection()

    @categories.fetch(reset: true)
    @tutorials.fetch(reset: true)
    @cakes.fetch(reset: true).done ->
      csx.Application.start()
