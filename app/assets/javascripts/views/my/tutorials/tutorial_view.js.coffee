class CakeSide.Views.My.Tutorials.TutorialView extends Marionette.ItemView
  template: JST['templates/my/tutorials/tutorial']
  tagName: 'div'
  className: 'media'

  templateHelpers:
    displayDate: (date) ->
      new Date(date).toLocaleDateString()
