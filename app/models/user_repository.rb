class UserRepository
  def initialize(connection = User)
    @connection = connection
  end

  delegate :all, :includes, :find, to: :connection

  def ordered
    connection.order(creations_count: :desc)
  end

  def artists
    connection.includes(:avatar).where('creations_count > 0').order(creations_count: :desc)
  end

  def search_by(query)
    return connection.all if query.blank?
    connection.where('name like :query or email like :query', query: "#{query}%")
  end

  private

  attr_reader :connection
end
