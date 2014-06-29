CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.ShowView extends Marionette.CompositeView
  template: JST["backbone/templates/photos/show"]
  childView: CakeSide.Views.Cakes.ThumbnailView
  childViewContainer: '.thumbnails'
  modelEvents:
    'sync': 'render'
