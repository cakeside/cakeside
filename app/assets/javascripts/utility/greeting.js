var Greeting = (function(){
  var Greeting = function(){
    this.greet = function(name) {
      return 'hi ' + name;
    };
    this.goodbye = function(name){
      return 'goodbye ' + name;
    };
  };
  return function(){
    return new Greeting();
  };
})();
