class CakeSide.Behaviour
  @on: (event) ->
    behaviour = new this()
    $(document).on event, () =>
      behaviour.execute()
