class csx.AutoCollection
  @install: (collectionName, json) ->
    csx.Collections[collectionName] = @create(json)

  @create: (json) ->
    new Backbone.Collection(json)
