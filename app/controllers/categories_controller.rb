class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_slug(params[:slug])
    @categories = Category.all
    @creations = @category.creations.includes(:user).page(params[:page]).per(12)
  end
end
