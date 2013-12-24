class FindAllCreationsQuery
  def initialize(repository = Creation)
    @repository = repository
  end

  def fetch(params)
    @repository.visible_creations.page(params[:page]).per(9)
  end
end
