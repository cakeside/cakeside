CakeSide.Views.Tutorials ||= {}

class CakeSide.Views.Tutorials.TutorialView extends Marionette.ItemView
  template: JST['backbone/templates/tutorials/tutorial']
  tagName: 'li'
  className: 'span3'

  templateHelpers:
    displayDate: (date) ->
      new Date(date).toLocaleDateString()
