describe "CakeSide.Views.Cakes.CakeView", ->
  cake = new CakeSide.Models.Cake
    id: '1'
    name: 'chocolate'
  subject = new CakeSide.Views.Cakes.CakeView
    model: cake

  describe "when there are no photos", ->
    beforeEach ->
      subject.render()

    it 'renders the cake', ->
      expect(subject.$el.html()).toMatch(/chocolate/)

    it 'does not display any photos', ->
      expect(subject.$el.html()).not.toMatch(/img/)
