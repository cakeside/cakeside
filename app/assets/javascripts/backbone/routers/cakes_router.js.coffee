class CakeSide.Routers.CakesRouter extends Marionette.AppRouter
  controller: new CakeSide.Controllers.CakesController()
  appRoutes:
    "cakes/new": "newCake"
    "cakes/:id/edit": "edit"
    "cakes/:id": "show"
    "cakes": "index"

