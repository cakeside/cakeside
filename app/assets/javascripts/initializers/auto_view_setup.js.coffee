#= require ./behaviour

class CakeSide.AutoViewSetup extends CakeSide.Behaviour
  @on "ready"
  @on "ajaxComplete"

  execute: ->
    for element in $('[data-autoview]')
      $element = $(element)
      @install($element) unless $element.data('autoview-setup-complete')

  install: (element) ->
    viewName = element.data('autoview')
    if viewName.indexOf("-") > 0
      CakeSide.AutoView.install(element)
    else
      constructor = CakeSide.Proxy.create(CakeSide.Views, viewName)
      CakeSide.AutoView.create(viewName, element, constructor)
    element.data('autoview-setup-complete', true)
