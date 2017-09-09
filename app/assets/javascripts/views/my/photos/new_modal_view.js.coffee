class csx.Views.My.Photos.NewModalView extends Marionette.ItemView
  template: JST["templates/my/photos/new-modal"]
  ui:
    watermark: '#watermark'
    upload_button: "#upload-photo-button"

  events:
    "click #upload-photo-button": "save"
    "change #photo-attachment": "displayPreview"
    "keyup #watermark": "updateWatermark"

  constructor: (options) ->
    super(options)
    @collection = csx.Application.request('PhotosRepository', options.cake.id)
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
      @model.set('thumb_url', event.target.result)
    else
      $('#preview-image').addClass('hide')

  displayProgress: (progress) ->
    percentCompleted = progress*100
    @set('percentComplete', percentCompleted)

  closeDialog: (photo) ->
    $('#modal').modal('hide')
    @remove()

  updateWatermark: ->
    @model.set('watermark', @ui.watermark.val())
