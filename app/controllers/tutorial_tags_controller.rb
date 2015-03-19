class TutorialTagsController < ApplicationController
  def index
    @tags = Tutorial.tag_counts_on(:tags)
  end

  def show
    @tag = params[:id].downcase.gsub(/ /, '-')
    @tutorials = Tutorial.tagged_with(@tag).includes([:tags]).page(params[:page]).per(12)
  end
end
