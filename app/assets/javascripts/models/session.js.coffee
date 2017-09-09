class CakeSide.Models.Session extends Backbone.Model
  EMAIL_REGEX=/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
  modelKey: 'session'
  defaults:
    email: null
    password: null

  requiredFields: ['email', 'password']

  validate: (attributes, options) ->
    errors = {}

    if !EMAIL_REGEX.test(attributes.email)
      errors['email'] = @errorFor('email', 'invalid')

    _.each @requiredFields, (field) =>
      if _.isEmpty(attributes[field])
        errors[field] = @errorFor(field, 'blank')

    return errors if _.keys(errors).length > 0

  errorFor: (attribute, scope) ->
    attributeName = I18n.t("activerecord.attributes.#{@modelKey}.#{attribute}")
    error = I18n.t("errors.messages.#{scope}")
    "#{attributeName} #{error}"
