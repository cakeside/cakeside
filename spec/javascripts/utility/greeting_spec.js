describe ("Greeting", function() {
  beforeEach (function() {
    sut = new Greeting();
  });
  var sut;
  describe ("when greeting someone", function() {
    it ("should say their name", function() {
      expect(sut.greet('mo')).toEqual('hi mo');
    });
  });
  describe ("when saying goodbye", function() {
    it ("should say their name", function() {
      expect(sut.goodbye('joe')).toEqual('goodbye joe');
    });
  });
});
