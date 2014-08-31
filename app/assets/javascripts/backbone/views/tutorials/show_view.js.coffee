CakeSide.Views.Tutorials ||= {}

class CakeSide.Views.Tutorials.ShowView extends Marionette.ItemView
  template: JST["backbone/templates/tutorials/show"]
  templateHelpers:
    displayDate: (date) ->
      date
