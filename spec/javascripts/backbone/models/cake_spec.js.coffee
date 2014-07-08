describe "CakeSide.Models.Cake", ->
  createSUT = (attributes) ->
    new CakeSide.Models.Cake(attributes)

  describe "#validate", ->
    it "returns an error when the name is null", ->
      attributes =
        name: null
      cake = createSUT(attributes)
      expect(cake.validate(attributes, {})).not.toBe(null)
      expect(cake.isValid()).toBeFalsy()

    it "returns an error when the name is blank", ->
      attributes =
        name: ' '
      cake = createSUT(attributes)
      expect(cake.validate(attributes, {})).not.toBe(null)
      expect(cake.isValid()).toBeFalsy()


    it 'returns an error when the category is blank', ->
      attributes = 
        name: 'hi'
        category_id: null
      cake = createSUT(attributes)
      expect(cake.validate(attributes)).not.toBe(null)
      expect(cake.isValid()).toBeFalsy()

    it 'is valid when a name and category is specified', ->
      attributes =
        name: 'hi'
        category_id: 1
      cake = createSUT(attributes)
      expect(cake.validate(attributes)).toBeUndefined()
      expect(cake.isValid()).toBeTruthy()
