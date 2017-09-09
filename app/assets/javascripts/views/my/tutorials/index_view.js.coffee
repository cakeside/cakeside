#= require views/my/tutorials/no_tutorials_view
#= require views/my/tutorials/tutorial_view

class csx.Views.My.Tutorials.IndexView extends Marionette.CollectionView
  childView: csx.Views.My.Tutorials.TutorialView
  emptyView: csx.Views.My.Tutorials.NoTutorialsView
  className: ''
  tagName: 'div'
