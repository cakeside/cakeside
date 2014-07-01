CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.NewModalView extends Backbone.View
  template: JST["backbone/templates/photos/new-modal"]

  events:
    "click #upload-photo-button": "save"
    "change #photo-attachment": "displayPreview"

  constructor: (options) ->
    super(options)
    @collection = CakeSide.Application.request('PhotosRepository', options.cake.id)
    @cake = options.cake
    @model = new @collection.model(cake_id: @cake.id)

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    fileObject = @$(':input[type="file"]')[0].files[0]
    @model.set('image', fileObject)
    @model.on('progress', @displayProgress)
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

  displayPreview: (event) ->
    input = event.currentTarget
    if (input.files && input.files[0])
      reader = new FileReader()
      reader.onload = (e) ->
        $('#preview-image').attr('src', e.target.result)
        $('#preview-image').removeClass('hide')
      reader.readAsDataURL(input.files[0])
    else
      $('#preview-image').addClass('hide')

  displayProgress: (event) ->
    CakeSide.Application.vent.trigger('uploading', event)
