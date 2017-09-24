#= require service/embedly_service

class csx.Views.My.Tutorials.NewView extends Marionette.ItemView
  template: JST['templates/my/tutorials/new']
  ui:
    url: '#tutorial_url'
    url_group: '#url-group'
    save_button: '#save-button'
    preview: '#preview-panel'
    tags: '#tutorial_tags'

  modelEvents:
    'invalid': 'displayError'
    'change:url': 'render'

  events:
    'change #tutorial_url': 'loadUrl'
    "submit #new-tutorial": "save"

  initialize: ->
    @model = new @collection.model()
    @service = new csx.EmbedlyService()

  loadUrl: ->
    if @model.isValidUrl(@ui.url.val())
      @service.retrieve_info_on(@ui.url.val(), @updateTutorial)
    @validate()

  updateTutorial: (attributes) =>
    @model.set
      url: attributes.url
      heading: attributes.title
      description: attributes.description
      image_url: if _.any(attributes.images) then attributes.images[0].url else ''
      author: attributes.provider_name
      author_url: attributes.provider_url

  onRender: ->
    @ui.tags.tagit({ availableTags: csx.Tags.pluck('name') })

  validate: ->
    @model.isValid()

  displayError: (model, error) ->
    @ui.save_button.attr('disabled', 'disabled')
    @ui.preview.hide()
    @ui.url_group.addClass("error")
    errorTag = $('<span>').addClass('help-inline').text(error)
    @ui.url_group.find('.controls').append(errorTag)

  save: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @model.set('tags', @ui.tags.val())
    @ui.save_button.attr('disabled', 'disabled')
    @collection.create(@model,
      success: @savedSuccessfully
      error: @couldNotSave
    )

  savedSuccessfully: (cake) =>
    window.location.hash = "tutorials"

  couldNotSave: (cake, xhr) =>
    @ui.save_button.removeAttr('disabled')
    error = new csx.Views.ErrorView
      el: @$('form#new-tutorial'),
      attributesWithErrors: $.parseJSON(xhr.responseText)
    error.render()
