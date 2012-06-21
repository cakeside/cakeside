class SitemapController < ApplicationController
  layout nil

  def index
    @creations = Creation.all
    @base_url = "http://#{request.host_with_port}"
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.html
      format.xml
    end
  end
end
