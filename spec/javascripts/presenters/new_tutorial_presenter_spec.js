describe ("NewTutorialPresenter", function() {
  beforeEach (function() {
    view = {
      add_tag:null,
      add_tag_button: $('<button id="add-tag-button">'),
      tag_list: $('<ul id="tag-list">'),
      tag_input: $('<input type="text" />'),
    };
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
  describe ("when the add tag button is clicked", function() {
    it ("should add the new tag to the list of tags", function() {
      expect(view.tag_list.html()).toEqual('<li><a href="#" class="label">ruby</a></li>');
    });
    beforeEach (function() {
      sut.present();
      view.tag_input.val('ruby');
      view.add_tag_button.trigger('click');
    });
  });
});
