#= require ./behaviour

class CakeSide.InfiniteScroll extends CakeSide.Behaviour
  @on "scroll"

  execute: ->
    $moreButton = $('[data-infinite-scroll]')
    return if $moreButton.length == 0

    if $(window).scrollTop() >= ($(document).height() - $(window).height())*0.8
      $moreButton.trigger('click')
