describe ("Greeting", function() {
  beforeEach (function() {
    sut = new Greeting();
  });
  describe ("when saying hello", function() {
    it ("should say your name", function() {
      expect(sut.greet('Mo')).toEqual('hi Mo');
    });
  });
});
