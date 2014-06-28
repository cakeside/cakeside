class CakeSide.Models.Photo extends Backbone.Model
  paramRoot: 'photo'
  fileAttribute: 'image'

  defaults:
    id: 0
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
    @url="/api/v1/cakes/#{options.cake_id}/photos"
