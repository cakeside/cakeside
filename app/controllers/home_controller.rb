class HomeController < ApplicationController
  def index
    @creations = Creation.all.reverse.take(6)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creations }
    end
  end
end
