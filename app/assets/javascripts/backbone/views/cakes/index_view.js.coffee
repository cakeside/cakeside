Cake.Views.Cakes ||= {}

class Cake.Views.Cakes.IndexView extends Backbone.View
  template: JST["backbone/templates/cakes/index"]

  initialize: () ->
    @options.cakes.bind('reset', @addAll)

  addAll: () =>
    @options.cakes.each(@addOne)

  addOne: (cake) =>
    view = new Cake.Views.Cakes.CakeView({model : cake})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(cakes: @options.cakes.toJSON() ))
    @addAll()

    return this
