class CakeSide.Controllers.ProfileController extends Marionette.Controller
  views: CakeSide.Views.Profiles
  initialize: (options) ->
    @content_region = CakeSide.Application.content_region

  show: ->
    @selectTab()
    profile = new CakeSide.Models.Profile
      id: 'me'
    profile.fetch
      success: =>
        @content_region.show(new @views.ShowView(model: profile))

  selectTab: ->
    $('.nav-list').children().removeClass('active')
    $('#settings-tab').addClass('active')
