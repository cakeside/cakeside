class window.EmbedlyService
  retrieve_info_on: (url, callback) ->
    $.embedly(url, {}, callback)
