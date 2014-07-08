describe "CakeSide.Views.Cakes.CakeView", ->
  cake = new CakeSide.Models.Cake
    name: 'chocolate'
  view = new CakeSide.Views.Cakes.CakeView
    model: cake

  describe "when there are no photos", ->
    beforeEach ->
      view.render()

    it 'renders the cake', ->
      expect(view.$el.html()).toMatch(/chocolate/)

    it 'does not display any photos', ->
      expect(view.$el.html()).not.toMatch(/img/)
