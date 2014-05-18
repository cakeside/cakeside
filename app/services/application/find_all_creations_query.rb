class FindAllCreationsQuery
  def initialize(repository = CreationRepository.new)
    @repository = repository
  end

  def fetch(params)
    @repository.visible_creations.page(params[:page]).per(params[:per_page] || 12)
  end
end
