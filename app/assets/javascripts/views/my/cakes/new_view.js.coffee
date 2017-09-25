class csx.Views.My.Cakes.NewView extends Marionette.ItemView
  template: JST["templates/my/cakes/new"]
  ui:
    name: "#cake_name"
    category: "#cake_category_id"
    save_button: '#save-button'

  modelEvents:
    'invalid': 'displayError'

  events:
    "keyup input": "refreshStatus"
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
    @model.isValid()

  savedSuccessfully: (cake) =>
    window.location.hash = "cakes/#{cake.id}/edit"

  couldNotSave: (cake, xhr) =>
    @enableSaveButton()
    error = new csx.Views.ErrorView
      el: @$('form#new-cake'),
      attributesWithErrors: $.parseJSON(xhr.responseText)
    error.render()

  refreshStatus: ->
    @enableSaveButton()
    @model.set('name', @ui.name.val())
    @model.set('category_id', @ui.category.val())
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
      categories: csx.Collections.Category.toJSON(),
    }
