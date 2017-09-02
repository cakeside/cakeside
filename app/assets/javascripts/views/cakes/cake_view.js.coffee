CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.CakeView extends Marionette.ItemView
  template: JST["templates/cakes/cake"]
  tagName: 'div'
  className: 'media'
  templateHelpers:
    randomPhoto: ->
      @photos[Math.floor(Math.random()*@photos.length)]
    hasImage: ->
      typeof(@photos) != 'undefined' && _.any(@photos)
    shrink: (message) ->
      message.substring(0, 12)
