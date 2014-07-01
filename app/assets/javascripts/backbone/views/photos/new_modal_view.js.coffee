CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.NewModalView extends Marionette.ItemView
  template: JST["backbone/templates/photos/new-modal"]
  ui:
    upload_button: "#upload-photo-button"

  events:
    "click #upload-photo-button": "save"
    "change #photo-attachment": "displayPreview"

  constructor: (options) ->
    super(options)
    @collection = CakeSide.Application.request('PhotosRepository', options.cake.id)
    @cake = options.cake
    @model = new @collection.model(cake_id: @cake.id)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @closeDialog()
    @model.on('progress', @displayProgress)
    @collection.create(@model)

  displayPreview: (event) ->
    input = event.currentTarget
    if (input.files && input.files[0])
      file = input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $('#preview-image').attr('src', e.target.result)
        $('#preview-image').removeClass('hide')
      reader.readAsDataURL(file)
      @model.set('image', file)
    else
      $('#preview-image').addClass('hide')

  displayProgress: (progress) ->
    debugger
    percentCompleted = progress*100
    @model.set('percentComplete', percentCompleted)

  closeDialog: (photo) ->
    $('#modal').modal('hide')
