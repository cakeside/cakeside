#= require service/embedly_service
class CakeSide.Views.Tutorials.NewView extends Marionette.ItemView
  template: JST['backbone/templates/tutorials/new']
  ui:
    url: '#tutorial_url'
    url_group: '#url-group'
    save_button: '#save-button'
    preview: '#preview-panel'

  modelEvents:
    'invalid': 'displayError'
    'change:url': 'render'

  events:
    'change #tutorial_url': 'loadUrl'

  initialize: ->
    @model = new @collection.model()
    @service = new EmbedlyService()

  loadUrl: ->
    @updateTutorial(url: @ui.url.val())
    if @model.isValidUrl(@ui.url.val())
      @service.retrieve_info_on(@ui.url.val(), @updateTutorial)

  updateTutorial: (attributes) =>
    @model.set
      url: attributes.url
      heading: attributes.title
      description: attributes.description
      image_url: attributes.thumbnail_url
      author: attributes.provider_name
      author_url: attributes.provider_url

  onRender: ->
    @model.isValid()

  displayError: (model, error) ->
    @ui.save_button.attr('disabled', 'disabled')
    @ui.preview.hide()
    @ui.url_group.addClass("error")
    errorTag = $('<span>').addClass('help-inline').text(error)
    @ui.url_group.find('.controls').append(errorTag)
