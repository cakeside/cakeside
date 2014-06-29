CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.ShowView extends Marionette.ItemView
  template: JST["backbone/templates/photos/show"]
  modelEvents:
    'sync': 'render'
