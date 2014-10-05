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
    return "Email is invalid" unless @validateEmail(attributes.email)
    return "URL is invalid" if attributes.website && !@validateUrl(attributes.website)
    return "Twitter handle is invalid" if !@validateTwitter(attributes.twitter)

  validateEmail: (email) ->
    regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    regex.test(email)

  validateUrl: (url) ->
    regex = new RegExp( "^" + "(?:(?:https?|ftp)://)" + "(?:\\S+(?::\\S*)?@)?" + "(?:" + "(?!(?:10|127)(?:\\.\\d{1,3}){3})" + "(?!(?:169\\.254|192\\.168)(?:\\.\\d{1,3}){2})" + "(?!172\\.(?:1[6-9]|2\\d|3[0-1])(?:\\.\\d{1,3}){2})" + "(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])" + "(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}" + "(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))" + "|" + "(?:(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)" + "(?:\\.(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)*" + "(?:\\.(?:[a-z\\u00a1-\\uffff]{2,}))" + ")" + "(?::\\d{2,5})?" + "(?:/\\S*)?" + "$", "i")
    regex.test(url)

  validateTwitter: (twitter) ->
    return true unless twitter
    regex = /^@?(\w){1,15}$/
    regex.test(twitter)

class CakeSide.Collections.ProfilesCollection extends Backbone.Collection
  model: CakeSide.Models.Profile
  url: '/api/v1/profiles'
