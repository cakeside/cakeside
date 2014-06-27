class Cake.Routers.CakesRouter extends Backbone.Router
  initialize: (options) ->
    @cakes = new Cake.Collections.CakesCollection()
    @cakes.fetch(reset: true).done ->
      Backbone.history.start()

  routes:
    "new"      : "newCake"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"

  newCake: ->
    @view = new Cake.Views.Cakes.NewView(collection: @cakes)
    $("#backbone-content").html(@view.render().el)

  index: ->
    @view = new Cake.Views.Cakes.IndexView(collection: @cakes)
    $("#backbone-content").html(@view.render().el)

  show: (id) ->
    cake = @cakes.get(id)
    @view = new Cake.Views.Cakes.ShowView(model: cake)
    $("#backbone-content").html(@view.render().el)

  edit: (id) ->
    cake = @cakes.get(id)

    @view = new Cake.Views.Cakes.EditView(model: cake)
    $("#backbone-content").html(@view.render().el)
