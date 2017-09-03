#= require ./behaviour

class CakeSide.InfiniteScroll extends CakeSide.Behaviour
  PERCENTAGE=0.8
  @on "scroll"

  execute: ->
    $moreButton = $('[data-infinite-scroll]')
    return if $moreButton.length == 0

    top = $(window).scrollTop()
    height = ($(document).height() - $(window).height())
    if top >= height * PERCENTAGE
      $moreButton.trigger('click')
