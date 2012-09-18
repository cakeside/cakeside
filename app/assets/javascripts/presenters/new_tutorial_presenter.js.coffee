class window.NewTutorialPresenter
  constructor:(@view, @service) ->

  present:() ->
    @view.add_tag_button.bind 'click', (event) =>
      this.add_tag(@view.tag_input.val())
    @view.url_input.bind 'change', (event) =>
      @service.retrieve_info_on(@view.url_input.val(), (data) => this.display_url_info(data))

  create_list_item_for:(tag) ->
    '<a href="tags/"><span class="label">'+tag+'</span></a>'

  add_tag:(new_tag) ->
    @view.tag_list.append(this.create_list_item_for(new_tag))
    if @view.hidden_tag_list.val() == ''
      @view.hidden_tag_list.val(new_tag)
    else
      @view.hidden_tag_list.val( @view.hidden_tag_list.val() + ', ' + new_tag)

  display_url_info:(data) ->
    @view.preview.heading.val(data.title)
    @view.preview.heading.text(data.title)
    @view.preview.description.text(data.description)
    @view.preview.image.attr('src', data.thumbnail_url)
    @view.preview.hidden_image_url.val(data.thumbnail_url)
