class CakeSide.Views.DisqusView extends Backbone.View
  el: "#disqus_thread"
  initialize: (options) ->
    disqus = document.createElement('script')
    disqus.type = 'text/javascript'
    disqus.async = true
    disqus.src = "//#{options.disqus_shortname}.disqus.com/embed.js"
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(disqus)

  render: (options) ->
    try
      @$el.removeClass('hidden')
      that = @
      DISQUS.reset
        reload: true,
        config: ->
          @page.identifier = options.identifier
          @page.title = "CakeSide - #{options.title}"
          @page.url = options.url
          @callbacks.onNewComment = [that.saveComment]
      @
    catch error
      console.log(error)
    finally
      @

  hide: ->
    @$el.addClass('hidden')

  saveComment: (comment) ->
    $.post Routes.comments_path(), { id: comment.id, url: document.URL, comment: comment }, (result) ->
      console.log(result)
