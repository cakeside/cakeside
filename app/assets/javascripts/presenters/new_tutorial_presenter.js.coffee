class window.NewTutorialPresenter
  constructor:(@view) ->

  add_tag: (tag) ->
    @view.add_tag('<li><a href="#" class="label">'+tag+'</a></li>')

