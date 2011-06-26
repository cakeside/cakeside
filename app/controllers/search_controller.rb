class SearchController < ApplicationController
  def index
    @creations = Creation.search(params[:q], :include => :user, :match_mode => :extended, :star => true).page(params[:page]).per(6)
    @search = params[:q]
  end
end
