class SearchController < ApplicationController
  def index
    @creations = Creation.search params[:search], :include => :user, :match_mode => :boolean
  end

end
