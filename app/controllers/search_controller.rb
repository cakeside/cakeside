class SearchController < ApplicationController
  def index
    respond_to do |format|
      if params[:q].blank? 
        format.html { redirect_to(home_index_url) }
      else
        sql = "%"+params[:q]+"%"
        @creations = Creation.where("upper(name) like upper(?) OR upper(story) like upper(?)", sql, sql).page(params[:page]).per(8)
        ## @creations = Creation.search(params[:q], :include => :user, :match_mode => :extended, :star => true).page(params[:page]).per(6)
        @members = User.where("upper(name) like upper(?)", sql).page(params[:page]).per(8)
        @search = params[:q]
        format.html
      end
    end
  end
end
