var Greeting = (function(){
  var Greeting = function(){
    this.greet = function(name) {
      return 'Hi ' + name;
    };
    
  };
  return function(){
    return new Greeting();
  };
})();
