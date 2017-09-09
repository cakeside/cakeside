#= require ./behaviour

class csx.AutoViewSetup extends csx.Behaviour
  @on "ready"
  @on "ajaxComplete"

  execute: ->
    for element in $('[data-autoview]')
      $element = $(element)
      @install($element) unless $element.data('autoview-setup-complete')

  install: (element) ->
    viewName = element.data('autoview')
    if viewName.indexOf("-") > 0
      csx.AutoView.install(element)
    else
      constructor = csx.Proxy.create(csx.Views, viewName)
      csx.AutoView.create(viewName, element, constructor)
    element.data('autoview-setup-complete', true)
