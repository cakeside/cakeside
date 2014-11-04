#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./controllers
#= require_tree ./routers

window.CakeSide =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Controllers: {}
  initialize: (data) ->
    $(document).ajaxSend  (event, xhr) ->
      if data.access_token
        xhr.setRequestHeader "Authorization", "Token token=#{data.access_token}"

    CakeSide.Application = new Marionette.Application()
    CakeSide.Application.addRegions
      content_region: '#backbone-content'
      comment_region: '#disqus_thread'

    CakeSide.Application.addInitializer (options) ->
      new CakeSide.Routers.CakesRouter
        controller: new CakeSide.Controllers.CakesController()
      new CakeSide.Routers.TutorialsRouter
        controller: new CakeSide.Controllers.TutorialsController()
      new CakeSide.Routers.DashboardRouter
        controller: new CakeSide.Controllers.DashboardController()
      new CakeSide.Routers.ProfileRouter
        controller: new CakeSide.Controllers.ProfileController()

    CakeSide.Application.on 'start', ->
      if Backbone.history
        Backbone.history.start()

    @cakes = new CakeSide.Collections.CakesCollection()
    @categories = new CakeSide.Collections.CategoriesCollection()
    @tutorials = new CakeSide.Collections.TutorialsCollection()

    #@disqus_view = new CakeSide.Views.DisqusView
      #disqus_shortname: data.disqus_shortname
    #CakeSide.Application.reqres.setHandler 'CommentView', =>
      #@disqus_view
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
        photos.fetch(reset: true)
        photos
    CakeSide.Application.reqres.setHandler 'TutorialsRepository', =>
      @tutorials
    CakeSide.Application.reqres.setHandler 'ProfilesRepository', =>
      @profiles ||= new CakeSide.Collections.ProfilesCollection()

    @cakes.fetch(reset: true).done ->
      CakeSide.Application.start()
    @categories.fetch(reset: true)
    @tutorials.fetch(reset: true)
