class SearchController < ApplicationController
  def index
    @search = params[:q]
    if @search.blank? 
      redirect_to(home_index_url)
    else
      @creations = Creation.search(@search).page(params[:page]).per(100)
      @members = User.where("upper(name) like upper(?)", "%#{@search}%")
    end
  end
end
