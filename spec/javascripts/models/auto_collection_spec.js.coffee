describe "AutoCollection", ->
  subject = null
  beforeEach ->
    subject = csx.AutoCollection

  describe ".install", ->
    it "installs a categories collection", ->
      subject.install('Category', [id: 1, name: 'cakes'])

      collection = csx.Collections.Category
      expect(collection).not.toBe(undefined)
      expect(collection.length).toEqual(1)
      expect(collection.first().get('name')).toEqual('cakes')

    it "binds the proper model", ->
      subject.install('Category', [])
      expect(csx.Collections.Category.model).toEqual(csx.Models.Category)

    it "binds the proper url", ->
      subject.install('Cake', [])
      expect(csx.Collections.Cake.url).toEqual('/api/v1/cakes')


#class csx.Collections.CakesCollection extends Backbone.Collection
  #model: csx.Models.Cake
  #url: '/api/v1/cakes'

