#= require views/cakes/thumbnail_view

CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.ShowView extends Marionette.CompositeView
  template: JST["templates/cakes/show"]
  childView: CakeSide.Views.Cakes.ThumbnailView
  childViewContainer: '.card-columns'

  events:
    "click .add-photo": "launchAddPhoto"
    "click #remove-cake-button": "removeCake"

  templateHelpers:
    hasImage: ->
      typeof(@photos) != 'undefined' && _.any(@photos)

    randomPhoto: ->
      if @primary_photo_id
        _.find @photos, (photo) =>
          photo.id.toString() == @primary_photo_id
      else
        @photos[Math.floor(Math.random()*@photos.length)]

  constructor: (options) ->
    super(options)
    @collection = @model.photos()
    @model.set('primary_photo_id', options.photo_id) if options.photo_id

  launchAddPhoto: ->
    @displayModal(new CakeSide.Views.Photos.NewModalView(cake: @model))

  removeCake: ->
    @displayModal(new CakeSide.Views.Cakes.DeleteCakeModalView(model: @model))

  displayModal: (view) ->
    $("#modal").html(view.render().el)
    $("#modal").modal()
