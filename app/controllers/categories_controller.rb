class CategoriesController < ApplicationController
  # GET /categories/fondant
  def show
    @category = Category.find_by_slug(params[:id])
    if @category
      @creations = Creation.includes(:user).joins(:categories).where(:categories => {:slug => params[:id]}).page(params[:page]).per(12)
    else
      redirect_to "/tags/#{params[:id]}"
    end
  end
end
