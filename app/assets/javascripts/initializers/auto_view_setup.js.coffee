#= require ./behaviour

class CakeSide.AutoViewSetup extends CakeSide.Behaviour
  @views = {}
  @on "ready"

  constructor: (logger = console) ->
    @logger = logger

  execute: ->
    for element in $('[data-autoview]')
      #CakeSide.AutoView.install(element)
      @install($(element))

  install: (element) ->
    viewName = element.data('autoview')
    constructor = CakeSide.Proxy.create(CakeSide.Views, viewName)

    if _.isUndefined(constructor)
      @logger.error("Could not find autoview for #{viewName}")
      return

    view = new constructor
      el: element
      $el: $(element)
    view.render()

    CakeSide.AutoViewSetup.views[viewName.replace('.', '')] = view
