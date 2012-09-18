class window.NewTutorialPresenter
  constructor:(@view) ->

  present:() ->
    @view.add_tag_button.bind 'click', (event) =>
      new_tag = @view.tag_input.val()
      @view.tag_list.append(this.create_list_item_for(new_tag))
      current = @view.hidden_tag_list.val()
      if current == ''
        @view.hidden_tag_list.val( new_tag)
      else
        @view.hidden_tag_list.val( current + ', ' + new_tag)

  create_list_item_for:(tag) ->
    '<li><a href="#" class="label">'+tag+'</a></li>'

