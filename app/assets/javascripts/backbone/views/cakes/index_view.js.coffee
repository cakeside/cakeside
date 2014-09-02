#= require backbone/views/cakes/no_cakes_view
CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.IndexView extends Marionette.CollectionView
  childView: CakeSide.Views.Cakes.CakeView
  emptyView: CakeSide.Views.Cakes.NoCakesView
  className: ''
  tagName: 'div'
