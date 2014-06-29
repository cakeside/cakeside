class CakeSide.Models.Category extends Backbone.Model
  paramRoot: 'category'

  defaults:
    name: null
    slug: null

class CakeSide.Collections.CategoriesCollection extends Backbone.Collection
  model: CakeSide.Models.Category
  url: '/api/v1/categories'
