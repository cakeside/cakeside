class SearchController < ApplicationController
  def index
    if params[:q].blank? 
      @creations = []
      @search = nil
    else
      sql = "%"+params[:q]+"%"
      @creations = Creation.where("name like ? OR story like ?", sql, sql).page(params[:page]).per(8)
      @members = User.where("name like ?", sql).page(params[:page]).per(8)
      # @creations = Creation.search(params[:q], :include => :user, :match_mode => :extended, :star => true).page(params[:page]).per(6)
      @search = params[:q]
    end
  end
end
