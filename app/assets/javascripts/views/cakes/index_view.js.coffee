#= require views/cakes/no_cakes_view

class CakeSide.Views.Cakes.IndexView extends Marionette.CollectionView
  childView: CakeSide.Views.Cakes.CakeView
  emptyView: CakeSide.Views.Cakes.NoCakesView
  className: ''
  tagName: 'div'
