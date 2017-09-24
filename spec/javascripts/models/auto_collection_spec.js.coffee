describe "AutoCollection", ->
  subject = null
  beforeEach ->
    subject = csx.AutoCollection

  describe ".install", ->
    it "installs a categories collection", ->
      subject.install('Category', 'categories', [id: 1, name: 'cakes'])

      collection = csx.Collections.Category
      expect(collection).not.toBe(undefined)
      expect(collection.length).toEqual(1)
      expect(collection.first().get('name')).toEqual('cakes')

    it "binds the proper model", ->
      subject.install('Category', 'categories', [])
      expect(csx.Collections.Category.model).toEqual(csx.Models.Category)

    it "binds the proper url", ->
      subject.install('Cake', 'cakes', [])
      expect(csx.Collections.Cake.url).toEqual('/api/v1/cakes')

    it "works for models that do not map to a backbone model", ->
      subject.install('Tag', 'acts_as_taggable_on_tags', [])
      expect(csx.Collections.Tag.model).toEqual(Backbone.Model)
      expect(csx.Collections.Tag.url).toEqual(undefined)
