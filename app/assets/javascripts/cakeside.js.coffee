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
    csx.Application.addRegions(content_region: '#backbone-content')
    csx.Application.addInitializer (options) ->
      new csx.Routers.CakesRouter(controller: new csx.Controllers.My.CakesController())
      new csx.Routers.TutorialsRouter(controller: new csx.Controllers.My.TutorialsController())
      new csx.Routers.DashboardRouter(controller: new csx.Controllers.My.DashboardController())
      new csx.Routers.ProfileRouter(controller: new csx.Controllers.My.ProfileController())
    csx.Application.on 'start', ->
      if Backbone.history
        Backbone.history.start()
    csx.Application.start()
