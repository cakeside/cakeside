//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require jquery.ui.all
//= require jquery.validate
//= require jquery.embedly
//= require tag-it
//= require bootstrap
//= require bootstrap-multiselect
//= require underscore
//= require js-routes
//= require backbone
//= require backbone.marionette
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/cakeside
//= require backbone-model-file-upload
//= require_tree .

var initialize = function(){
  $('.tooltip-item').tooltip();
  $(window).scroll(function(){
    if ($(window).scrollTop() >= ($(document).height() - $(window).height())*0.8){
      $('.more-button').trigger('click');
    }
  });
};
$(document).ready(initialize);
$(document).on("page:load", initialize);
