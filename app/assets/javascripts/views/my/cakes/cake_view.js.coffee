class csx.Views.My.Cakes.CakeView extends Marionette.ItemView
  template: JST["templates/my/cakes/cake"]
  tagName: 'div'
  className: 'media'
  templateHelpers:
    randomPhoto: ->
      @photos[Math.floor(Math.random()*@photos.length)]
    hasImage: ->
      typeof(@photos) != 'undefined' && _.any(@photos)
    shrink: (message) ->
      message.substring(0, 12)
