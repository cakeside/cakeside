CakeSide.Views.Photos ||= {}

class CakeSide.Views.Photos.NewModalView extends Marionette.ItemView
  template: JST["backbone/templates/photos/new-modal"]
  ui:
    upload_button: "#upload-photo-button"

  modelEvents:
    'progress': 'displayProgress'

  events:
    "click #upload-photo-button": "save"
    "change #photo-attachment": "displayPreview"

  templateHelpers:
    uploading: ->
      typeof(@percentComplete) != "undefined"


  constructor: (options) ->
    super(options)
    @collection = CakeSide.Application.request('PhotosRepository', options.cake.id)
    @cake = options.cake
    @model = new @collection.model(cake_id: @cake.id)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @ui.upload_button.attr('disabled', 'disabled')
    @collection.create(@model, success: @photoUploaded)

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

  displayProgress: (percentComplete) ->
    CakeSide.Application.vent.trigger('uploading', event)
    @model.set('percentComplete', percentComplete*100)
    @render()

  photoUploaded: (photo) ->
    $('#modal').modal('hide')
