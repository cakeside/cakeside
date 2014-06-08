class FindAllCreationsQuery
  DEFAULT_PER_PAGE=12

  def initialize(repository = CreationRepository.new)
    @repository = repository
  end

  def fetch(params)
    @repository.visible_creations.page(params[:page]).per(params[:per_page] || DEFAULT_PER_PAGE)
  end
end
