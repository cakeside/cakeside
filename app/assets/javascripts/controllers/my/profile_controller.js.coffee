class CakeSide.Controllers.My.ProfileController extends Marionette.Controller
  views: CakeSide.Views.My.Profiles
  initialize: (options) ->
    @content_region = CakeSide.Application.content_region
    #@comment_view = CakeSide.Application.request('CommentView')

  show: (id) ->
    @selectTab()
    #@comment_view.hide()
    profile = new CakeSide.Models.Profile
      id: id
    profile.fetch
      success: =>
        @content_region.show(new @views.ShowView(model: profile))

  selectTab: ->
    $('.nav-link').removeClass('active')
    $('a[href="/my#profile/me"]').addClass('active')
