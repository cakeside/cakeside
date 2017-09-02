class CakeSide.Views.Tutorials.ShowView extends Marionette.ItemView
  template: JST["templates/tutorials/show"]
  templateHelpers:
    displayDate: (date) ->
      date
