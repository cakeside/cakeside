CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.NewView extends Marionette.ItemView
  template: JST["backbone/templates/cakes/new"]
  ui:
    name: "#cake_name"
    watermark: "#cake_watermark"
    description: "#cake_story"
    category: "#cake_category_id"
    tags: "#cake_tags"
    is_restricted: "#cake_is_restricted"
    save_button: '#save-button'

  modelEvents:
    'invalid': 'displayError'

  events:
    "change input": "refreshStatus"
    "change select": "refreshStatus"
    "submit #new-cake": "save"

  constructor: (options) ->
    super(_.extend(options, { model: new options.collection.model() }))

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @disableSaveButton()
    @collection.create(@model,
      success: @savedSuccessfully
      error: @couldNotSave
    )

  onRender: ->
    @$("#cake_category_id").val($("#cake_category_id option:first").val())
    @$('#cake_tags').tagit({ availableTags: ALL_TAGS })
    @$('.tooltip-item').tooltip()

  savedSuccessfully: (cake) =>
    window.location.hash = "/cakes/#{cake.id}/photos/new"

  couldNotSave: (cake, xhr) =>
    @enableSaveButton()
    error = new CakeSide.Views.ErrorView
      el: @$('form#new-cake'),
      attributesWithErrors: $.parseJSON(xhr.responseText)
    error.render()

  refreshStatus: ->
    @enableSaveButton()
    @model.set('name', @ui.name.val())
    @model.set('watermark', @ui.watermark.val())
    @model.set('story', @ui.description.val())
    @model.set('category_id', @ui.category.val())
    @model.set('tags', @ui.tags.val())
    @model.set('is_restricted', @ui.is_restricted.val())
    @model.isValid()

  displayError: (model, error) ->
    @disableSaveButton()

  enableSaveButton: ->
    @ui.save_button.removeAttr('disabled')

  disableSaveButton: ->
    @ui.save_button.attr('disabled', 'disabled')

  serializeData: ->
    {
      cake: @model.toJSON(),
      categories: CakeSide.Application.request('CategoriesRepository').toJSON(),
    }

