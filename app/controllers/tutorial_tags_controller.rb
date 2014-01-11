class TutorialTagsController < ApplicationController
  def index
    @tags = Tutorial.tag_counts_on(:tags)
    expires_in(6.hours)
  end

  def show
    @tag = params[:id].downcase.gsub(/ /, '-')
    @total_tutorials = Tutorial.tagged_with(@tag).count
    @total_creations = Creation.tagged_with(@tag).count
    @tutorials = Tutorial.includes(:tags).tagged_with(@tag).page(params[:page]).per(15)
    expires_in(6.hours)
  end
end
