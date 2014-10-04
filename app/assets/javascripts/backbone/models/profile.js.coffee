class CakeSide.Models.Profile extends Backbone.Model
  paramRoot: 'profile'
  urlRoot: '/api/v1/profiles'
  modelEvents:
    "change": "render"

  defaults:
    id: null
    name: null
    email: null
    city: null
    website: null
    facebook: null
    twitter: null

  validate: (attributes, options) ->
    return "Name can't be blank" unless attributes.name && attributes.name.trim()
    return "Email can't be blank" unless attributes.email && attributes.email.trim()

class CakeSide.Collections.ProfilesCollection extends Backbone.Collection
  model: CakeSide.Models.Profile
  url: '/api/v1/profiles'
