class AllCakesQuery
  def initialize(repository = Spank::IOC.resolve(:cakes))
    @repository = repository
  end

  def fetch(params)
    @repository.filtered_by(search_filters_for(params))
  end

  private

  def search_filters_for(params)
    [
      ->(cakes) { cakes.published },
      ->(cakes) { params[:category].blank? ? cakes.all : cakes.where(category_id: Category.find_by_slug(params[:category].downcase).id) },
      ->(cakes) { cakes.order(created_at: sort(params)) },
    ]
  end

  def sort(params)
    params[:sort] == "oldest" ? :asc : :desc
  end
end
