#= require ./behaviour

class CakeSide.InfiniteScroll extends CakeSide.Behaviour
  @on "scroll"

  execute: ->
    if $(window).scrollTop() >= ($(document).height() - $(window).height())*0.8
      $('.more-button').trigger('click')
