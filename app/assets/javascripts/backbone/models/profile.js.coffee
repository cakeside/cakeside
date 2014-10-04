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

class CakeSide.Collections.ProfilesCollection extends Backbone.Collection
  model: CakeSide.Models.Profile
  url: '/api/v1/profiles'
