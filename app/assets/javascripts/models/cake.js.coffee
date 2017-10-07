class csx.Models.Cake extends Backbone.Model
  paramRoot: 'cake'

  defaults:
    id: null
    name: null
    story: null
    created_at: null
    updated_at: null
    category_id: null

  validate: (attributes, options) ->
    return "Name can't be blank" unless attributes.name && attributes.name.trim()
    return "Category can't be blank" unless attributes.category_id

  photos: ->
    cake_id = @id
    new Backbone.Collection(csx.Collections.Photo.filter((photo) => photo.get("cake_id") == cake_id))

  public_url: ->
    "#{window.location.origin}/creations/#{@get('slug')}"

  category_id: ->
    @get('category_id') || @get('category').id

class csx.Collections.CakesCollection extends Backbone.Collection
  model: csx.Models.Cake
  url: '/api/v1/cakes'

csx.Models.Creation = csx.Models.Cake
