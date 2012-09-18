class window.NewTutorialPresenter
  constructor:(@view) ->

  present:() ->
    @view.add_tag_button.bind 'click', (event) =>
      @view.tag_list.append(this.create_list_item_for(@view.tag_input.val()))

  create_list_item_for:(tag) ->
    '<li><a href="#" class="label">'+tag+'</a></li>'

