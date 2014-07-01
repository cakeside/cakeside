#= require backbone/views/cakes/thumbnail_view
CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.ShowView extends Marionette.CompositeView
  template: JST["backbone/templates/cakes/show"]
  childView: CakeSide.Views.Cakes.ThumbnailView
  childViewContainer: '.thumbnails'

  events:
    "click #add-photo": "launchAddPhoto"

  templateHelpers:
    hasImage: ->
      typeof(@photos) != 'undefined' && _.any(@photos)

    randomPhoto: ->
      @photos[Math.floor(Math.random()*@photos.length)]

  constructor: (options) ->
    super(options)
    @collection = @model.photos()

  launchAddPhoto: ->
    view = new CakeSide.Views.Photos.NewModalView(cake: @model)
    $("#modal").html(view.render().el)
    $("#modal").modal()
