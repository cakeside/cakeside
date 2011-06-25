class SearchController < ApplicationController
  def index
    @creations = Creation.search params[:q], :include => :user, :match_mode => :extended, :star => true, :page => 1, :per_page => 20
    @search = params[:q]
  end
end
