Cake.Views.Photos ||= {}

class Cake.Views.Photos.NewModalView extends Backbone.View
  template: JST["backbone/templates/photos/new-modal"]

  events:
    "click #upload-photo-button": "save"

  constructor: (options) ->
    super(options)
    @collection = new Cake.Collections.PhotosCollection(cake_id: options.cake.id)
    @model = new @collection.model()
    @cake = options.cake

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
        $('#modal').modal('hide')

      error: (photo, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON()))
    this.$("form").backboneLink(@model)
    return this
