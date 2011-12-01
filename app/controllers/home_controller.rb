class HomeController < ApplicationController
  def index
    @creations = Creation.page(params[:page]).per(8)
  end
end
