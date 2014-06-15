#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Cake =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  initialize: (data) ->
    $(document).ajaxSend  (event, xhr) ->
      if data.access_token
        xhr.setRequestHeader "Authorization", "Token token=" + data.access_token
    new Cake.Routers.CakesRouter()
