class SitemapController < ApplicationController
  layout nil

  def index
    @creations = Creation.all
    @tutorials = Tutorial.all
    @base_url = "https://#{request.host_with_port}"
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml
    end
  end
end
