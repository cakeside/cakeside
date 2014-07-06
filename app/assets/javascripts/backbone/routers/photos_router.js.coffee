class CakeSide.Routers.PhotosRouter extends Marionette.AppRouter
  controller: new CakeSide.Controllers.PhotosController()
  appRoutes:
    "cakes/:cake_id/photos/:id": "show"
