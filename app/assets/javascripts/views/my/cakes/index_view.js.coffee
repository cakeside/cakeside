#= require views/my/cakes/no_cakes_view

class CakeSide.Views.My.Cakes.IndexView extends Marionette.CollectionView
  childView: CakeSide.Views.My.Cakes.CakeView
  emptyView: CakeSide.Views.My.Cakes.NoCakesView
  className: ''
  tagName: 'div'
