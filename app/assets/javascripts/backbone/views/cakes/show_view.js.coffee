Cake.Views.Cakes ||= {}

class Cake.Views.Cakes.ShowView extends Backbone.View
  template: JST["backbone/templates/cakes/show"]

  events:
    "click #add-photo": "launchAddPhoto"

  constructor: (options) ->
    super(options)
    @model.on('sync', @render)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

  launchAddPhoto: ->
    view = new Cake.Views.Photos.NewModalView(cake: @model)
    $("#modal").html(view.render().el)
    $("#modal").modal()
