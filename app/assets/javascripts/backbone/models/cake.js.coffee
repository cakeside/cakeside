class Cake.Models.Cake extends Backbone.Model
  paramRoot: 'cake'

  defaults:
    name: null
    watermark: null
    story: null

  validate: (attributes, options) ->
    return "Name can't be blank" unless attributes.name && attributes.name.trim()
    return "Category can't be blank" unless attributes.category_id

class Cake.Collections.CakesCollection extends Backbone.Collection
  model: Cake.Models.Cake
  url: '/api/v1/cakes'
