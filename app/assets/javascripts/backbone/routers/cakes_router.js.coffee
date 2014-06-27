class Cake.Routers.CakesRouter extends Backbone.Router
  routes:
    "new"      : "newCake"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"

  index: ->
    @view = new Cake.Views.Cakes.IndexView(collection: Cake.Application.request('CakeRepository'))
    $("#backbone-content").html(@view.render().el)

  show: (id) ->
    cake = Cake.Application.request('CakeRepository').get(id)
    @view = new Cake.Views.Cakes.ShowView(model: cake)
    $("#backbone-content").html(@view.render().el)

  newCake: ->
    @view = new Cake.Views.Cakes.NewView(collection: Cake.Application.request('CakeRepository'))
    $("#backbone-content").html(@view.render().el)

  edit: (id) ->
    cake = Cake.Application.request('CakeRepository').get(id)

    @view = new Cake.Views.Cakes.EditView(model: cake)
    $("#backbone-content").html(@view.render().el)
