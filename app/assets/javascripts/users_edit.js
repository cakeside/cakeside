var DeviseUsers = DeviseUsers || {};

DeviseUsers.Edit = {
  initialize: function($){
    $('#edit_user').validate();
    $('#user_city').autocomplete({
      source: function(request, response){
        $.ajax({
          url: 'http://ws.geonames.org/searchJSON',
          dataType: "jsonp",
          data: {
            featureClass: "P",
            style: 'full',
            maxRows: 12,
            name_startsWith: request.term
          },
          success: function(data){
            response( $.map(data.geonames, function(item){
              return {
                label: item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
                value: item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
                latitude: item.lat,
                longitude: item.lng
              }
            }));
          }
        });
      },
      minlength:2,
      select:function(event, ui){
        var item = ui.item;
        $('#user_latitude').val(item.latitude);
        $('#user_longitude').val(item.longitude);
      }
    });
  }
};
