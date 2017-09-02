#= require views/my/tutorials/no_tutorials_view
#= require views/my/tutorials/tutorial_view

class CakeSide.Views.My.Tutorials.IndexView extends Marionette.CollectionView
  childView: CakeSide.Views.My.Tutorials.TutorialView
  emptyView: CakeSide.Views.My.Tutorials.NoTutorialsView
  className: ''
  tagName: 'div'
