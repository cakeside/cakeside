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
    $(document).ajaxSend  (event, xhr) ->
      if data.access_token
        xhr.setRequestHeader "Authorization", "Token token=#{data.access_token}"

    Cake.Application = new Marionette.Application()
    Cake.Application.addInitializer (options) ->
      new Cake.Routers.CakesRouter()
      new Cake.Routers.PhotosRouter()

    Cake.Application.on 'start', ->
      if Backbone.history
        Backbone.history.start()

    @cakes = new Cake.Collections.CakesCollection()
    Cake.Application.reqres.setHandler 'CakeRepository', =>
      @cakes

    @cakes.fetch(reset: true).done ->
      Cake.Application.start()
