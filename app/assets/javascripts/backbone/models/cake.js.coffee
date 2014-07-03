class CakeSide.Models.Cake extends Backbone.Model
  paramRoot: 'cake'

  defaults:
    id: null
    name: null
    watermark: null
    story: null
    created_at: null
    updated_at: null
    is_restricted: false
    category_id: null

  validate: (attributes, options) ->
    return "Name can't be blank" unless attributes.name && attributes.name.trim()
    return "Category can't be blank" unless attributes.category_id

  photos: ->
    CakeSide.Application.request('PhotosRepository', @id)

class CakeSide.Collections.CakesCollection extends Backbone.Collection
  model: CakeSide.Models.Cake
  url: '/api/v1/cakes'
