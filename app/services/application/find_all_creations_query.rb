class FindAllCreationsQuery
  DEFAULT_PER_PAGE=12

  def initialize(repository = CreationRepository.new)
    @repository = repository
  end

  def fetch(params)
    @repository.visible_creations.order(created_at: sort(params)).page(params[:page]).per(per_page(params))
  end

  private

  def per_page(params)
    params[:per_page] || DEFAULT_PER_PAGE
  end

  def sort(params)
    params[:sort] == "newest" ? :asc : :desc
  end
end

