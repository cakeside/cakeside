class csx.AutoCollection
  @install: (modelName, pluralName, json) ->
    model = csx.Models[modelName]
    if _.isUndefined(model)
      csx.Collections[modelName] = new Backbone.Collection(json)
    else
      collection = Backbone.Collection.extend
        model: model
        url: "/api/v1/#{pluralName}"
      csx.Collections[modelName] = new collection(json)
