CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.ThumbnailView extends Marionette.ItemView
  template: JST['backbone/templates/cakes/thumbnail']
  modelEvents:
    'sync': 'render'
    'change:percentComplete': 'render'

  templateHelpers:
    uploading: ->
      typeof(@percentComplete) != "undefined"
