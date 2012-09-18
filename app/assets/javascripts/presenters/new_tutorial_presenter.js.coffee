class window.NewTutorialPresenter
  constructor:(@view) ->

  present:() ->
    @view.add_tag_button.bind 'click', (event) =>
      @view.tag_list.append('<li><a href="#" class="label">'+@view.tag_input.val()+'</a></li>')

  add_tag: (tag) ->
    @view.add_tag('<li><a href="#" class="label">'+tag+'</a></li>')

