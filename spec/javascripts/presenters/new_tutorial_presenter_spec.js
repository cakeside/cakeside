describe ("NewTutorialPresenter", function() {
  beforeEach (function() {
    view = {
      add_tag_button: $('<button id="add-tag-button">'),
      tag_list: $('<ul id="tag-list">'),
      tag_input: $('<input type="text" />'),
      hidden_tag_list: $('<input type="hidden" />'),
      url_input: $('<input type="text" />'),
      preview: {
        heading: $('<h3>'),
        description: $('<p>'),
        image: $('<img>'),
        hidden_image_url: $('<input type="hidden">'),
      }
    };
    service = {
      retrieve_info_on:null
    };
    sut = new NewTutorialPresenter(view, service);
  });
  var sut;
  var view;
  var service;

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
  describe ("when a url is entered", function() {
    it ("should connect to embedly to retrieve information about the url", function() {
      expect(service.retrieve_info_on).toHaveBeenCalledWith(url, sut.display_url_info);
    });
    beforeEach (function() {
      spyOn(service, 'retrieve_info_on');
      sut.present();
      url = 'http://mokhan.ca/';
      view.url_input.val(url);
      view.url_input.trigger('change');
    });
    var url;
  });
  describe ("when information is received about a url", function() {
    it ("should update the preview heading", function() {
      expect(view.preview.heading.text()).toEqual('the title');
    });
    it ("should update the preview description", function() {
      expect(view.preview.description.text()).toEqual('the description');
    });
    it ("should update the preview image", function() {
      expect(view.preview.image.attr('src')).toEqual('http://');
    });
    it ("should update the hidden input image url", function() {
      expect(view.preview.hidden_image_url.val()).toEqual('http://');
    });
    beforeEach (function() {
      var payload = {
        title: 'the title',
        description: 'the description',
        thumbnail_url: 'http://'
      };
      sut.display_url_info(payload);
    });
  });
});
