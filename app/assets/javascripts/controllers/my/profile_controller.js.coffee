class csx.Controllers.My.ProfileController extends Marionette.Controller
  views: csx.Views.My.Profiles
  initialize: (options) ->
    @content_region = csx.Application.content_region

  show: (id) ->
    @selectTab()
    profile = new csx.Models.Profile
      id: id
    profile.fetch
      success: =>
        @content_region.show(new @views.ShowView(model: profile))

  selectTab: ->
    $('.nav-link').removeClass('active')
    $('a[href="/my#profile/me"]').addClass('active')
