class Cake.Models.Cake extends Backbone.Model
  paramRoot: 'cake'

  defaults:
    name: null
    story: null

class Cake.Collections.CakesCollection extends Backbone.Collection
  model: Cake.Models.Cake
  url: '/cakes'
