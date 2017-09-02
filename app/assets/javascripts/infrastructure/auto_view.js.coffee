class CakeSide.AutoView extends Backbone.View
  @views: {}
  @constructors: {}

  @viewName: (name) ->
    @constructors[name] = this

  @install: (element) ->
    name = $(element).data('autoview')
    constructor = @constructors[name]
    if constructor == undefined
      console.error("Could not find autoview for #{name}")
      return

    view = new constructor
      el: element
      $el: $(element)
    view.render()
    @views[name] ?= []
    @views[name].push(view)

  render: -> { }
