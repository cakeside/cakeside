#= require ./behaviour

class CakeSide.AutoViewSetup extends CakeSide.Behaviour
  @on "ready"

  execute: ->
    for element in $('[data-autoview]')
      @install($(element))

  install: (element) ->
    viewName = element.data('autoview')
    if viewName.indexOf("-") > 0
      CakeSide.AutoView.install(element)
    else
      constructor = CakeSide.Proxy.create(CakeSide.Views, viewName)
      CakeSide.AutoView.create(viewName, element, constructor)
