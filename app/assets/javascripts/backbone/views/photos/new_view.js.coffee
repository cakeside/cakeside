Cake.Views.Photos ||= {}

class Cake.Views.Photos.NewView extends Backbone.View
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
    photo = new Cake.Models.Photo(cake_id: 100)
    photo.url = => @collection.url
    photo.set('image', fileObject)
    photo.on('progress', console.log)
    photo.save()

    #@model.set('image', fileObject)
    #@model.save()
    #@model.on('progress', console.log)
    #@collection.create(@model.toJSON(),
      #success: (photo) =>
        #@model = photo
        #window.location.hash = "/#{@model.id}"

      #error: (photo, jqXHR) =>
        #@model.set({errors: $.parseJSON(jqXHR.responseText)})
    #)

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
