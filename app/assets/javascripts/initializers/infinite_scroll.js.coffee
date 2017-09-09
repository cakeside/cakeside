#= require ./behaviour

class csx.InfiniteScroll extends csx.Behaviour
  PERCENTAGE=0.8
  @on "scroll"

  execute: ->
    $moreButton = $('[data-infinite-scroll]')
    return if $moreButton.length == 0

    top = $(window).scrollTop()
    height = ($(document).height() - $(window).height())
    if top >= height * PERCENTAGE
      $moreButton.trigger('click')
