#= require service/embedly_service
class CakeSide.Views.Tutorials.NewView extends Marionette.ItemView
  template: JST['backbone/templates/tutorials/new']
  ui:
    url: '#tutorial_url'
    save_button: '#save-button'

  events:
    'change #tutorial_url': 'loadUrl'

  templateHelpers:
    canLoadPreview: ->
      @image_url

  initialize: ->
    @model = new @collection.model()
    @service = new EmbedlyService()

  loadUrl: ->
    url = @ui.url.val()
    @resetTutorial(url)
    @service.retrieve_info_on(url, @loadUrlInformation)

  loadUrlInformation: (data) =>
    @model.set('url', data.url)
    @model.set('heading', data.title)
    @model.set('description', data.description)
    @model.set('image_url', data.thumbnail_url)
    @model.set('author', data.provider_name)
    @model.set('author_url', data.provider_url)
    @render()
    if @model.isValid()
      @enableSaveButton()
    else
      @disableSaveButton()

  resetTutorial: (url) ->
    @model.set('url', url)
    @model.set('heading', '')
    @model.set('description', '')
    @model.set('image_url', '')
    @model.set('author', '')
    @model.set('author_url', '')
    @disableSaveButton()
    @render()

  enableSaveButton: ->
    @ui.save_button.removeAttr('disabled')

  disableSaveButton: ->
    @ui.save_button.attr('disabled', 'disabled')
