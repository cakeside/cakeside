describe "CakeSide.AutoViewSetup", ->
  subject = null
  logger = null

  beforeEach ->
    spyOn(console, 'error')
    subject = new CakeSide.AutoViewSetup()

  describe "#execute", ->
    beforeEach ->
      CakeSide.AutoViewSetup.views = {}

    it 'attaches the autoview to the DOM element', ->
      fixture.set '<div data-autoview="My.ChangePassword"></div>'
      subject.execute()
      result = CakeSide.AutoViewSetup.views['MyChangePassword']
      expect(result instanceof CakeSide.Views.My.ChangePassword).toEqual(true)

    it "returns nil if the autoview cannot be discovered", ->
      fixture.set '<div data-autoview="Unknown"></div>'
      subject.execute()

      expect(_.isEmpty(CakeSide.AutoViewSetup.views)).toEqual(true)
      expect(console.error).toHaveBeenCalled()
