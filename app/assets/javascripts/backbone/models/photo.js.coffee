class CakeSide.Models.Photo extends Backbone.Model
  paramRoot: 'photo'
  fileAttribute: 'image'

  defaults:
    id: null
    cake_id: null
    content_type: null
    original_filename: null
    thumb_url: null
    large_url: null
    original_url: null
    created_at: null
    updated_at: null

class CakeSide.Collections.PhotosCollection extends Backbone.Collection
  model: CakeSide.Models.Photo

  initialize: (options) ->
    @set('cake_id', options.cake_id)
    @url="/api/v1/cakes/#{options.cake_id}/photos"
