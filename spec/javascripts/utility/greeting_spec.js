describe ("Greeting", function() {
  beforeEach (function() {
    sut = new Greeting('mo');
  });
  var sut;
  describe ("when greeting someone", function() {
    it ("should say their name", function() {
      expect(sut.greet()).toEqual('hi mo');
    });
  });
  describe ("when saying goodbye", function() {
    it ("should say their name", function() {
      expect(sut.goodbye()).toEqual('goodbye mo');
    });
  });
});
