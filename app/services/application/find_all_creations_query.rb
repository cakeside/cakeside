class FindAllCreationsQuery
  def initialize(repository = CreationRepository.new)
    @repository = repository
  end

  def fetch(params)
    @repository.visible_creations.page(params[:page]).per(12)
  end
end
