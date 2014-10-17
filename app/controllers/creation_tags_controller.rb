class CreationTagsController < ApplicationController
  def initialize(repository = Spank::IOC.resolve(:cakes))
    @repository = repository
  end

  def index
    @tags = @repository.tag_counts_on(:tags)
  end

  def show
    @tag = params[:id].downcase.parameterize
    @creations = @repository.tagged(@tag).page(params[:page]).per(12)
  end
end
