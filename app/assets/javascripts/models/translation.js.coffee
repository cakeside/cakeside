class csx.Translation
  constructor: (modelKey) ->
    @modelKey = modelKey

  errorFor: (attribute, scope) ->
    attributeName = I18n.t("activerecord.attributes.#{@modelKey}.#{attribute}")
    error = I18n.t("errors.messages.#{scope}")
    "#{attributeName} #{error}"
