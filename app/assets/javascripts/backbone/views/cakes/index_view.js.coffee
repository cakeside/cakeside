Cake.Views.Cakes ||= {}

class Cake.Views.Cakes.IndexView extends Backbone.View
  template: JST["backbone/templates/cakes/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (cake) =>
    view = new Cake.Views.Cakes.CakeView({model : cake})
    @$(".thumbnails").append(view.render().el)

  render: =>
    $(@el).html(@template(cakes: @collection.toJSON() ))
    @addAll()

    return this
