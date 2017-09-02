class CakeSide.Behaviour
  @events: {}

  @on: (event) ->
    @events[event] ?= []
    @events[event].push(@)

  @install: ->
    for event of @events
      window.addEventListener event, () =>
        for behaviour in @events[event]
          new behaviour().execute()

