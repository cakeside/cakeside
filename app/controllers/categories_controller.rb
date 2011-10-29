class CategoriesController < ApplicationController
  # GET /categories/fondant
  def show
    @category = Category.where(:slug => params[:id]).first
    @creations = Creation.joins(:categories).where(:categories => {:slug => params[:id]}).page(params[:page]).per(6)
  end
end
