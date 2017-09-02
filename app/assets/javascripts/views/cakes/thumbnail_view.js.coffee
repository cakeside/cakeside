class CakeSide.Views.Cakes.ThumbnailView extends Marionette.ItemView
  template: JST['templates/cakes/thumbnail']
  tagName: 'div'
  className: 'card'
  modelEvents:
    'sync': 'render'
    'change:percentComplete': 'render'

  templateHelpers:
    uploading: ->
      typeof(@percentComplete) != "undefined" && @percentComplete != 100
