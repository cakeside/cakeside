class AllCakesQuery
  def initialize(repository = Spank::IOC.resolve(:cakes))
    @repository = repository
  end

  def fetch(params)
    @repository.search_with(params)
  end
end
