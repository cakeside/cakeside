class FindCreationQuery
  def initialize(repository = CreationRepository.new)
    @repository = repository
  end

  def fetch(id)
    @repository.find(id)
  end
end
