class csx.AutoCollection
  @install: (collectionName, json) ->
    csx[collectionName] = @create(json)

  @create: (json) ->
    new Backbone.Collection(json)
