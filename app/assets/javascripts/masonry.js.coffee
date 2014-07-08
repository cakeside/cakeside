class window.Masonry
  constructor: (container) ->
    @container = container

  load: ->
    $(@container).imagesLoaded =>
      $(@container).masonry
        itemSelector : '.span4'
        isResizable: true
