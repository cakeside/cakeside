#= require ./translation

class csx.Models.Search extends Backbone.Model
  translation: new csx.Translation('search')
  defaults:
    q: null

  requiredFields: ['q']

  validate: (attributes, options) ->
    errors = {}
    _.each @requiredFields, (field) =>
      if _.isEmpty(attributes[field])
        errors[field] = @translation.errorFor(field, 'blank')

    return errors if _.keys(errors).length > 0
