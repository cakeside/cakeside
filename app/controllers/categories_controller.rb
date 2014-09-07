class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_slug(params[:id].downcase)
    if @category
      @creations = @category.creations.includes(:user, :photos).page(params[:page]).per(12)
    else
      redirect_to creation_tag_path(params[:id].downcase), status: :moved_permanently
    end
  end
end
