class window.TutorialForm
  initialize:($) ->
    view = {
      add_tag_button: $('#add-tag-button'),
      tag_list: $('#tag-list'),
      tag_input: $('#tags'),
      hidden_tag_list: $('#hidden_tags'),
      url_input: $('#tutorial_url'),
      preview: {
        heading: $('.tutorial-heading'),
        description: $('.tutorial-description'),
        image: $('img.embed-thumb'),
        hidden_image_url: $('#tutorial_image_url'),
        author: $('.tutorial-author'),
        author_url: $('.tutorial-author-url'),
      }
    }
    new NewTutorialPresenter(view, new EmbedlyService($)).present()
