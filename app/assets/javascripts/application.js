//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.validate
//= require jquery.embedly
//= require tag-it
//= require popper
//= require bootstrap
//= require bootstrap-multiselect
//= require underscore
//= require js-routes
//= require backbone
//= require backbone.marionette
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone-model-file-upload
//= require cakeside
//= require_self

CakeSide.Behaviour.install()
var initialize = function(){
  $(window).scroll(function(){
    if ($(window).scrollTop() >= ($(document).height() - $(window).height())*0.8){
      $('.more-button').trigger('click');
    }
  });
};
$(document).ready(initialize);
