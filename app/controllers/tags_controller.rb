class TagsController < ApplicationController
  def show
    @tag = params[:id].downcase.gsub(/ /, '-')
    @total_tutorials = Tutorial.tagged_with(@tag).count
    @total_creations = Creation.tagged_with(@tag).count
    @creations = Creation.includes(:user).tagged_with([@tag]).page(params[:page]).per(15)
  end
end
