class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_slug(params[:id])
    @creations = @category.creations.includes(:user).page(params[:page]).per(12)
  end
end
