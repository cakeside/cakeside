class csx.Models.Tutorial extends Backbone.Model
  paramRoot: 'tutorial'

  defaults:
    id: null
    url: null
    image_url: null
    heading: null
    description: null

  validate: (attributes, options) ->
    return "Invalid Url." unless @isValidUrl(attributes.url || '')
    return "This tutorial has no photos." unless @hasImage(attributes.image_url)

  isValidUrl: (url) ->
    expression = /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi;
    url.match(new RegExp(expression))

  hasImage: (image_url) ->
    image_url

class csx.Collections.TutorialsCollection extends Backbone.Collection
  model: csx.Models.Tutorial
  url: '/api/v1/tutorials'
