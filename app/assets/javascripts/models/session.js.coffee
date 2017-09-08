class CakeSide.Models.Session extends Backbone.Model
  modelKey: 'session'
  defaults:
    username: null
    password: null

  requiredFields: ['username', 'password']

  validate: (attributes, options) ->
    errors = {}

    _.each @requiredFields, (field) =>
      if _.isEmpty(attributes[field])
        errors[field] = @errorFor(field, 'blank')

    return errors if _.keys(errors).length > 0

  errorFor: (attribute, scope) ->
    attributeName = I18n.t("activerecord.attributes.#{@modelKey}.#{attribute}")
    error = I18n.t("errors.messages.#{scope}")
    "#{attributeName} #{error}"
