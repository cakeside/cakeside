#= require views/auto_view

class CakeSide.Views.Cakes.ShowPage extends CakeSide.AutoView
  @viewName "cakes#show"

  render: ->
    console.log(@name)
