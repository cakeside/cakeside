class CakeSide.Routers.CakesRouter extends Backbone.Router
  routes:
    "cakes/new": "newCake"
    "cakes/index": "index"
    "cakes/:id/edit": "edit"
    "cakes/:id": "show"
    "cakes/:id": "show"
    "cakes/.*": "index"
    ".*": "index"

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
