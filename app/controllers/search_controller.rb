class SearchController < ApplicationController
  def index
    @creations = Creation.search params[:q], :include => :user, :match_mode => :boolean
  end

end
