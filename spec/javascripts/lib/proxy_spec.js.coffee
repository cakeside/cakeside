describe "CakeSide.Proxy", ->
  subject = null

  describe "#create", ->
    object = null
    subject = CakeSide.Proxy

    beforeEach ->
      object =
        top: 'one'
        more:
          stuff: ['a','b']

    it 'gets the value of a shallow object reference', ->
      expect(subject.create(object, 'top')).toEqual(object.top)

    it 'gets the value of a deep object reference', ->
      expect(subject.create(object, 'more.stuff')).toEqual(object.more.stuff)

    it 'sets the value of a shallow object reference', ->
      subject.create(object, 'top', 'two')
      expect(object.top).toEqual('two')

    it 'sets the value of a deep object reference', ->
      subject.create(object, 'more.stuff', 5)
      expect(object.more.stuff).toEqual(5)

    it "returns undefined if a reference doesn't exist", ->
      expect(subject.create(object, 'non.existent.path')).toEqual(undefined)
