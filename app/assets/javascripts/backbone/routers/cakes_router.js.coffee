class CakeSide.Routers.CakesRouter extends Backbone.Router
  routes:
    "cakes/new": "newCake"
    "cakes/:id/edit": "edit"
    "cakes/:id": "show"
    "cakes": "index"

  index: ->
    CakeSide.Application.request('CommentView').hide()
    @view = new CakeSide.Views.Cakes.IndexView(collection: CakeSide.Application.request('CakesRepository'))
    CakeSide.Application.content_region.show(@view)

  show: (id) ->
    cake = CakeSide.Application.request('CakesRepository').get(id)
    @view = new CakeSide.Views.Cakes.ShowView(model: cake)
    CakeSide.Application.content_region.show(@view)
    CakeSide.Application.request('CommentView').render
      identifier: "c-#{cake.id}"
      title: cake.get('name')
      url: cake.public_url()

  newCake: ->
    CakeSide.Application.request('CommentView').hide()
    @view = new CakeSide.Views.Cakes.NewView(collection: CakeSide.Application.request('CakesRepository'))
    CakeSide.Application.content_region.show(@view)

  edit: (id) ->
    CakeSide.Application.request('CommentView').hide()
    cake = CakeSide.Application.request('CakesRepository').get(id)
    @view = new CakeSide.Views.Cakes.EditView(model: cake)
    CakeSide.Application.content_region.show(@view)
