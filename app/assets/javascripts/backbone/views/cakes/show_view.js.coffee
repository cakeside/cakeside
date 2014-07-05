#= require backbone/views/cakes/thumbnail_view
CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.ShowView extends Marionette.CompositeView
  template: JST["backbone/templates/cakes/show"]
  childView: CakeSide.Views.Cakes.ThumbnailView
  childViewContainer: '.thumbnails'

  events:
    "click .add-photo": "launchAddPhoto"
    "click #remove-cake-button": "removeCake"

  templateHelpers:
    hasImage: ->
      typeof(@photos) != 'undefined' && _.any(@photos)

    randomPhoto: ->
      @photos[Math.floor(Math.random()*@photos.length)]

  constructor: (options) ->
    super(options)
    @collection = @model.photos()
    @displayComments()

  launchAddPhoto: ->
    @displayModal(new CakeSide.Views.Photos.NewModalView(cake: @model))

  removeCake: ->
    @displayModal(new CakeSide.Views.Cakes.DeleteCakeModalView(model: @model))

  displayModal: (view) ->
    $("#modal").html(view.render().el)
    $("#modal").modal()

  displayComments: ->
    CakeSide.Application.request('CommentView').render
      identifier: "c-#{@model.id}"
      title: @model.get('name')
      url: @model.public_url()
