#= require ./behaviour

class CakeSide.AutoViewSetup extends CakeSide.Behaviour
  @on "ready"

  execute: ->
    for element in $('[data-autoview]')
      CakeSide.AutoView.install(element)
