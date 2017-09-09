describe "csx.AutoViewSetup", ->
  subject = null
  logger = null

  beforeEach ->
    spyOn(console, 'error')
    subject = new csx.AutoViewSetup()

  describe "#execute", ->

    beforeEach ->
      csx.AutoView.views = {}

    it 'attaches the autoview to the DOM element', ->
      fixture.set '<div id="item" data-autoview="My.ChangePassword"></div>'
      subject.execute()
      result = csx.AutoView.views['My-ChangePassword'][0]
      expect(result instanceof csx.Views.My.ChangePassword).toEqual(true)
      expect($('#item').data('autoview-setup-complete')).toEqual(true)

    it "returns nil if the autoview cannot be discovered", ->
      fixture.set '<div data-autoview="Unknown"></div>'
      subject.execute()

      expect(_.isEmpty(csx.AutoView.views)).toEqual(true)
      expect(console.error).toHaveBeenCalled()

    it "attaches the auto model to the auto view", ->
      class csx.TestView extends csx.AutoView
        @viewName 'test-view'

      class csx.Models.Test extends Backbone.Model
        defaults:
          test: null

      fixture.set '<div id="item" data-autoview="test-view" data-automodel="Test"></div>'
      subject.execute()
      result = csx.AutoView.views['test-view'][0]
      expect(result instanceof csx.TestView).toEqual(true)
      expect(result.model instanceof csx.Models.Test).toEqual(true)
