describe "AutoCollection", ->
  subject = null
  beforeEach ->
    subject = csx.AutoCollection

  describe ".install", ->
    it "installs a categories collection", ->
      subject.install('Categories', [id: 1, name: 'cakes'])

      expect(csx.Categories).not.toBe(undefined)
      expect(csx.Categories.length).toEqual(1)
      expect(csx.Categories.first().get('name')).toEqual('cakes')

