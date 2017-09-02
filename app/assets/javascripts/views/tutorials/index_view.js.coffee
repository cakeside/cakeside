#= require views/tutorials/no_tutorials_view
#= require views/tutorials/tutorial_view

class CakeSide.Views.Tutorials.IndexView extends Marionette.CollectionView
  childView: CakeSide.Views.Tutorials.TutorialView
  emptyView: CakeSide.Views.Tutorials.NoTutorialsView
  className: ''
  tagName: 'div'
