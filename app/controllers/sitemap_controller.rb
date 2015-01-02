class SitemapController < ApplicationController
  layout nil

  def index
    @creations = Creation.all
    @tutorials = Tutorial.all
    headers['Content-Type'] = 'application/xml'
    expires_in(1.hour)
    respond_to do |format|
      format.xml
    end
  end
end
