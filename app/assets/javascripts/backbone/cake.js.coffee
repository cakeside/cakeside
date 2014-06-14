#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Cake =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  initialize: (data) ->
    new Cake.Routers.CakesRouter({ cakes: data.cakes })
    Backbone.history.start()
