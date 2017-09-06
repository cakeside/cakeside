class CakeSide.AutoView extends Backbone.View
  @views: {}
  @constructors: {}

  @viewName: (name) ->
    @constructors[name] = this
    @::name = name

  @install: (element) ->
    name = $(element).data('autoview')
    constructor = @constructors[name]
    @create(name, element, constructor)

  @create: (name, element, constructor) ->
    if constructor == undefined
      console.error("Could not find autoview at #{name}")
      return

    view = new constructor
      el: element
      $el: $(element)
    view.render()
    key = name.replace(".", '-')
    @views[key] ?= []
    @views[key].push(view)

  hideErrors: () ->
    @$(':input').removeClass('is-invalid')
    @$('.invalid-feedback').html('')

  showError: (field, message) ->
    @$(field).addClass('is-invalid').siblings('.invalid-feedback').html(message)

  field: (name) -> @$("##{@fieldName(name)}")
  fieldName: (name) -> "#{@modelKey}_#{name}"
  render: -> @
