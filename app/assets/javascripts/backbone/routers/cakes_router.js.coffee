class CakeSide.Routers.CakesRouter extends Backbone.Router
  routes:
    "new"      : "newCake"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    "cakes/:id": "show"
    ".*"       : "index"

  index: ->
    @view = new CakeSide.Views.Cakes.IndexView(collection: CakeSide.Application.request('CakesRepository'))
    $("#backbone-content").html(@view.render().el)

  show: (id) ->
    cake = CakeSide.Application.request('CakesRepository').get(id)
    @view = new CakeSide.Views.Cakes.ShowView(model: cake)
    $("#backbone-content").html(@view.render().el)

  newCake: ->
    @view = new CakeSide.Views.Cakes.NewView(collection: CakeSide.Application.request('CakesRepository'))
    $("#backbone-content").html(@view.render().el)

  edit: (id) ->
    cake = CakeSide.Application.request('CakesRepository').get(id)
    @view = new CakeSide.Views.Cakes.EditView(model: cake)
    $("#backbone-content").html(@view.render().el)
