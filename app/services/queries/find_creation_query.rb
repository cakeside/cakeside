class FindCreationQuery
  def initialize(repository = Creation)
    @repository = repository
  end

  def fetch(id)
    @repository.find(id)
  end
end
