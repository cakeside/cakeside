CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.NewView extends Backbone.View
  template: JST["backbone/templates/photos/new"]

  events:
    "submit #new-photo": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    fileObject = @$(':input[type="file"]')[0].files[0]
    @model.set('image', fileObject)
    @model.on('progress', console.log)
    @collection.create(@model.toJSON(),
      success: (photo) =>
        @model = photo
        window.location.hash = "cakes/#{@model.get('cake_id')}"

      error: (photo, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON()))
    this.$("form").backboneLink(@model)
    return this
