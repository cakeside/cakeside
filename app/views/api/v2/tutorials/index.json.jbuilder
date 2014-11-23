json.tutorials @tutorials do |tutorial|
  json.partial! tutorial, tutorial: tutorial
end
json.meta do
  json.partial! 'api/v2/shared/pagination', items: @tutorials
end
