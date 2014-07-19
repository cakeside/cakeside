#= require service/embedly_service
class CakeSide.Views.Tutorials.NewView extends Marionette.ItemView
  template: JST['backbone/templates/tutorials/new']
  ui:
    url: '#tutorial_url'

  events:
    'change #tutorial_url': 'loadUrl'

  initialize: ->
    @model = new @collection.model()
    @service = new EmbedlyService()

  loadUrl: ->
    @service.retrieve_info_on(@ui.url.val(), @loadUrlInformation)

  loadUrlInformation: (data) =>
    @model.set('url', data.url)
    @model.set('heading', data.title)
    @model.set('description', data.description)
    @model.set('image_url', data.thumbnail_url)
    @model.set('author', data.provider_name)
    @model.set('author_url', data.provider_url)
    @render()
