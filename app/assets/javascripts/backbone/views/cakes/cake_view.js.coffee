CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.CakeView extends Marionette.ItemView
  template: JST["backbone/templates/cakes/cake"]
  tagName: 'li'
  className: 'span3'
  templateHelpers:
    randomPhoto: ->
      @photos[Math.floor(Math.random()*@photos.length)]
