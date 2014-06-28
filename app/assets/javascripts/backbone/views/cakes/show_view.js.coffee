CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.ThumbnailView extends Marionette.ItemView
  template: JST['backbone/templates/cakes/thumbnail']

class CakeSide.Views.Cakes.ShowView extends Marionette.CompositeView
  template: JST["backbone/templates/cakes/show"]
  childView: CakeSide.Views.Cakes.ThumbnailView
  childViewContainer: '.thumbnails'

  events:
    "click #add-photo": "launchAddPhoto"

  constructor: (options) ->
    super(options)
    #@model.on('sync', @render)
    @collection = @model.photos()

  #render: ->
    #$(@el).html(@template(@model.toJSON()))
    #return this

  launchAddPhoto: ->
    view = new CakeSide.Views.Photos.NewModalView(cake: @model)
    $("#modal").html(view.render().el)
    $("#modal").modal()
