#= require views/auto_view

class csx.Views.Cakes.ShowPage extends csx.AutoView
  @viewName "cakes#show"

  render: ->
    console.log(@name)
