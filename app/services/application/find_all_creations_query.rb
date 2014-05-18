class FindAllCreationsQuery
  def initialize(repository = Creation)
    @repository = repository
  end

  def fetch(params)
    @repository.visible_creations.page(params[:page]).per(12)
  end
end
