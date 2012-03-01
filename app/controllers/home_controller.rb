class HomeController < ApplicationController
  # to be removed
  def index
    @creations = Creation.page(params[:page]).per(16)
  end
end
