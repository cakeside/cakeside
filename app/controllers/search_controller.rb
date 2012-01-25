class SearchController < ApplicationController
  def index
    if params[:q].blank? 
      @creations = []
      @search = nil
    else
      sql = "%"+params[:q]+"%"
      @creations = Creation.where("upper(name) like upper(?) OR upper(story) like upper(?)", sql, sql).page(params[:page]).per(8)
      @members = User.where("upper(name) like upper(?)", sql).page(params[:page]).per(8)
      # @creations = Creation.search(params[:q], :include => :user, :match_mode => :extended, :star => true).page(params[:page]).per(6)
      @search = params[:q]
    end
  end
end
