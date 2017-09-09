#= require views/my/cakes/no_cakes_view

class csx.Views.My.Cakes.IndexView extends Marionette.CollectionView
  childView: csx.Views.My.Cakes.CakeView
  emptyView: csx.Views.My.Cakes.NoCakesView
  className: ''
  tagName: 'div'
