var Creations = Creations || {};
Creations.Show = {
  initialize: function(){
    $('.gallery').colorbox({
      rel:'gallery',
      width:function(){
        var width = '100%', viewport = $(window).width();
        if (viewport > 960) {
          width = '50%';
        } else if (viewport >= 768) {
          width = '80%';
        }
        return width;
      }
    });
  }
};
