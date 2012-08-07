class SearchController < ApplicationController
  def index
    respond_to do |format|
      if params[:q].blank? 
        format.html { redirect_to(home_index_url) }
      else
        sql = "%"+params[:q]+"%"
        @creations = Creation.where("upper(name) like upper(?) OR upper(story) like upper(?)", sql, sql).page(params[:page]).per(100)
        @members = User.where("upper(name) like upper(?)", sql)
        @search = params[:q]
        format.html
      end
    end
  end
end
