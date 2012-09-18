class window.NewTutorialPresenter
  constructor:(@view) ->

  present:() ->
    @view.add_tag_button.bind 'click', (event) =>
      this.add_tag(@view.tag_input.val())

  create_list_item_for:(tag) ->
    '<li><a href="#" class="label">'+tag+'</a></li>'

  add_tag:(new_tag) ->
    @view.tag_list.append(this.create_list_item_for(new_tag))
    if @view.hidden_tag_list.val() == ''
      @view.hidden_tag_list.val(new_tag)
    else
      @view.hidden_tag_list.val( @view.hidden_tag_list.val() + ', ' + new_tag)

