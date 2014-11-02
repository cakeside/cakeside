class CakeSide.Controllers.TutorialsController extends Marionette.Controller
  views: CakeSide.Views.Tutorials
  initialize: (options) ->
    @content_region = CakeSide.Application.content_region
    @tutorials = CakeSide.Application.request('TutorialsRepository')
    #@comment_view = CakeSide.Application.request('CommentView')

  index: ->
    @selectTab()
    #@comment_view.hide()
    @content_region.show(new @views.IndexView(collection: @tutorials))

  new: ->
    @selectTab()
    #@comment_view.hide()
    @content_region.show(new @views.NewView(collection: @tutorials))

  show: (id) ->
    @selectTab()
    tutorial = @tutorials.get(id)
    @content_region.show(new @views.ShowView(model: tutorial))
    #@comment_view.render
      #identifier: "t-#{tutorial.id}"
      #title: tutorial.get('heading')
      #url: tutorial.get('url')

  selectTab: ->
    $('.nav-list').children().removeClass('active')
    $('#tutorial-tab').addClass('active')
