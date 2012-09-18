describe ("NewTutorialPresenter", function() {
  beforeEach (function() {
    view = {add_tag:null};
    sut = new NewTutorialPresenter(view);
  });
  var sut;
  var view;
  describe ("when a new tag is added", function() {
    it ("should add the new tag to the list of tags", function() {
      expect(view.add_tag).toHaveBeenCalledWith('<li><a href="#" class="label">blah</a></li>');
    });
    beforeEach (function() {
      spyOn(view, 'add_tag');
      sut.add_tag('blah');
    });
  });
});
