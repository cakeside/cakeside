class HomeController < ApplicationController
  def index
    @creations = Creation.all.take(5).reverse

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creations }
    end
  end
end
