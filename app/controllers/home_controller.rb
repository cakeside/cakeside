class HomeController < ApplicationController
  def index
    @creations = Creation.page(params[:page]).per(16)
  end
end
