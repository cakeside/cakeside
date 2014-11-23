class CakeSide.Controllers.ProfileController extends Marionette.Controller
  views: CakeSide.Views.Profiles
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
    $('.nav-list').children().removeClass('active')
    $('#profile-tab').addClass('active')
