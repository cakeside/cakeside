var Creations = Creations || {};
Creations.Crop = {
  initialize:function(){
    $('#cropbox').Jcrop({
      onChange: update_crop,
      onSelect: update_crop,
      setSelect: [100, 100, 210, 150],
      aspectRatio: 1.4
    });
    function update_crop(coords) {
      var rx = 210/coords.w;
      var ry = 150/coords.h;
      var lw = $('#cropbox').width();
      var lh = $('#cropbox').height();

      $('#preview').css({
        width: Math.round(rx * lw) + 'px',
        height: Math.round(ry * lh) + 'px',
        marginLeft: '-' + Math.round(rx * coords.x) + 'px',
        marginTop: '-' + Math.round(ry * coords.y) + 'px'
      });

      $("#crop_x").val(coords.x);
      $("#crop_y").val(coords.y);
      $("#crop_w").val(coords.w);
      $("#crop_h").val(coords.h);
    }
  }
};
Creations.Show = {
  initialize: function(){
    $('.gallery').colorbox({rel:'gallery', width: "960px"});
  }
};
