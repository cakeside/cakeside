class CakeSide.Routers.CakesRouter extends Marionette.AppRouter
  appRoutes:
    "cakes/new": "newCake"
    "cakes/:id/edit": "edit"
    "cakes/:id": "show"
    "cakes": "index"
