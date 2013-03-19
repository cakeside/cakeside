class CategoriesController < ApplicationController
  # GET /categories/fondant
  def show
    @category = Category.where(:slug => params[:id]).first
    if @category
      @creations = Creation.joins(:categories).where(:categories => {:slug => params[:id]}).page(params[:page]).per(12)
    else
      redirect_to "/tags/#{params[:id]}"
    end
  end
end
