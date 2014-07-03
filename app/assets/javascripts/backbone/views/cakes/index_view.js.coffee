CakeSide.Views.Cakes ||= {}

class CakeSide.Views.Cakes.NoCakesView extends Marionette.ItemView
  template: JST["backbone/templates/cakes/no_cakes"]
  tagName: 'li'

class CakeSide.Views.Cakes.IndexView extends Marionette.CollectionView
  childView: CakeSide.Views.Cakes.CakeView
  emptyView: CakeSide.Views.Cakes.NoCakesView
  className: 'thumbnails'
  tagName: 'ul'
