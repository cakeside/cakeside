#= require ./translation

class csx.Models.PasswordReset extends Backbone.Model
  translation: new csx.Translation('user')
  defaults:
    email: null

  requiredFields: ['email']

  validate: (attributes, options) ->
    errors = {}

    unless new csx.Models.Email(attributes.email).isValid()
      errors['email'] = @translation.errorFor('email', 'invalid')

    _.each @requiredFields, (field) =>
      if _.isEmpty(attributes[field])
        errors[field] = @translation.errorFor(field, 'blank')

    return errors if _.keys(errors).length > 0
