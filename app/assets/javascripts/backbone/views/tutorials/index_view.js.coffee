#= require backbone/views/tutorials/no_tutorials_view
#= require backbone/views/tutorials/tutorial_view
CakeSide.Views.Tutorials ||= {}

class CakeSide.Views.Tutorials.IndexView extends Marionette.CollectionView
  childView: CakeSide.Views.Tutorials.TutorialView
  emptyView: CakeSide.Views.Tutorials.NoTutorialsView
  className: 'thumbnails'
  tagName: 'ul'
