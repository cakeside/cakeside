class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_slug(params[:slug].downcase)
    if @category
      @creations = @category.creations.includes(:user).page(params[:page]).per(12)
    else
      redirect_to creation_tag_path(params[:slug].downcase)
    end
  end
end
