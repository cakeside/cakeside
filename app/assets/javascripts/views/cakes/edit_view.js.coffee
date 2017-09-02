#= require views/cakes/thumbnail_view

class CakeSide.Views.Cakes.EditView extends Marionette.CompositeView
  template : JST["templates/cakes/edit"]
  childView: CakeSide.Views.Cakes.ThumbnailView
  childViewContainer: '.card-columns'
  ui:
    name: "#cake_name"
    description: "#cake_story"
    category: "#cake_category_id"
    tags: "#cake_tags"
    save_button: '#save-button'

  modelEvents:
    'invalid': 'displayError'

  events :
    "keyup input": "refreshStatus"
    "change select": "refreshStatus"
    "submit #edit-cake" : "update"
    "click .add-photo": "launchAddPhoto"

  constructor: (options) ->
    super(options)
    @collection = @model.photos()

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    @disableSaveButton()
    @model.save(null,
      success: @savedSuccessfully
      error: @couldNotSave
    )

  onRender: ->
    @$("#cake_category_id").val(@model.category_id())
    @ui.tags.tagit({ availableTags: ALL_TAGS })
    @disableSaveButton()

  savedSuccessfully: (cake) =>
    window.location.hash = "cakes/#{cake.id}"

  couldNotSave: (cake, xhr) =>
    @enableSaveButton()
    error = new CakeSide.Views.ErrorView
      el: @$('form#edit-cake'),
      attributesWithErrors: $.parseJSON(xhr.responseText)
    error.render()

  refreshStatus: ->
    @enableSaveButton()
    @model.set('name', @ui.name.val())
    @model.set('story', @ui.description.val())
    @model.set('category_id', @ui.category.val())
    @model.set('tags', @ui.tags.val())
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

  launchAddPhoto: ->
    @displayModal(new CakeSide.Views.Photos.NewModalView(cake: @model))

  displayModal: (view) ->
    $("#modal").html(view.render().el)
    $("#modal").modal()
