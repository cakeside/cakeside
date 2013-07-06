class SitemapController < ApplicationController
  layout nil

  def index
    @creations = Creation.all
    @tutorials = Tutorial.all
    @base_url = "http://#{request.host_with_port}"
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml
    end
  end

  def comments
    headers['Content-Type'] = 'application/xml'
    @comments = Comment.all
    respond_to do |format|
      format.xml
    end
  end
end
