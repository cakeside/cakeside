class csx.Models.Category extends Backbone.Model
  paramRoot: 'category'

  defaults:
    name: null
    slug: null

class csx.Collections.CategoriesCollection extends Backbone.Collection
  model: csx.Models.Category
  url: '/api/v1/categories'
