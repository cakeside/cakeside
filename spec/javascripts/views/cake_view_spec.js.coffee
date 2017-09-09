describe "csx.Views.My.Cakes.CakeView", ->
  cake = new csx.Models.Cake
    id: '1'
    name: 'chocolate'
  subject = new csx.Views.My.Cakes.CakeView
    model: cake

  describe "when there are no photos", ->
    beforeEach ->
      subject.render()

    it 'renders the cake', ->
      expect(subject.$el.html()).toMatch(/chocolate/)

    it 'does not display any photos', ->
      expect(subject.$el.html()).not.toMatch(/img/)
