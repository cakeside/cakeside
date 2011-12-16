class SearchController < ApplicationController
  def index
    sql = "%"+params[:q]+"%"
    @creations = Creation.where("name like ? OR story like ?", sql, sql).page(params[:page]).per(6)
    # @creations = Creation.search(params[:q], :include => :user, :match_mode => :extended, :star => true).page(params[:page]).per(6)
    @search = params[:q]
  end
end
