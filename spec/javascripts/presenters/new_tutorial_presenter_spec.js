describe ("NewTutorialPresenter", function() {
  beforeEach (function() {
    view = {
      add_tag_button: $('<button id="add-tag-button">'),
      tag_list: $('<ul id="tag-list">'),
      tag_input: $('<input type="text" />'),
      hidden_tag_list: $('<input type="hidden" />'),
    };
    sut = new NewTutorialPresenter(view);
  });
  var sut;
  var view;
  describe ("when the add tag button is clicked", function() {
    it ("should add the new tag to the list of tags", function() {
      expect(view.tag_list.html()).toEqual('<a href="tags/"><span class="label">ruby</span></a>');
    });
    it ("should add the new tag to the hidden list of tags", function() {
      expect(view.hidden_tag_list.val()).toEqual('ruby');
    });
    beforeEach (function() {
      sut.present();
      view.tag_input.val('ruby');
      view.add_tag_button.trigger('click');
    });
  });
  describe ("when multiple tags are added", function() {
    it ("should add each one to the hidden list", function() {
      expect(view.hidden_tag_list.val()).toEqual('ruby, javascript');
    });
    beforeEach (function() {
      sut.present();
      view.tag_input.val('ruby');
      view.add_tag_button.trigger('click');
      view.tag_input.val('javascript');
      view.add_tag_button.trigger('click');
    });
  });
});
