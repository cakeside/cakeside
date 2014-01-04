class window.Masonry
  constructor: (container) ->
    @container = container

  load: ->
    $(@container).imagesLoaded =>
      console.log("load masonry.")
      $(@container).masonry
        itemSelector : '.span4'
        isResizable: true
