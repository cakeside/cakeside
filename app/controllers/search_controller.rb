class SearchController < ApplicationController
  def index
    @creations = Creation.search params[:q], :include => :user, :match_mode => :any
    @search = params[:q]
  end

end
