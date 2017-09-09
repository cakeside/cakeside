class csx.Views.My.Tutorials.ShowView extends Marionette.ItemView
  template: JST["templates/my/tutorials/show"]
  templateHelpers:
    displayDate: (date) ->
      date
