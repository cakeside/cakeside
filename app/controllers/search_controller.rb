class SearchController < ApplicationController
  def initialize(creations_repository = CreationRepository.new)
    super()
    @creations_repository = creations_repository
  end

  def index
    @search = params[:q]
    if @search.blank?
      redirect_to(root_url)
    else
      @creations = @creations_repository.search(@search).page(params[:page]).per(100)
      @members = User.includes(:avatar).where("upper(name) like upper(?)", "%#{@search}%")
      @tutorials = Tutorial.where("upper(heading) like upper(?) OR upper(description) like upper(?)", "%#{@search}%", "%#{@search}%")
    end
  end
end
