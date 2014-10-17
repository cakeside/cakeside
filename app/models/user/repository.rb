class User
  scope :artists, ->{ where('creations_count > 0').order(creations_count: :desc) }
  scope :search_by, ->(query) { query.blank? ? self.scoped : where('name like :query or email like :query', query: "#{query}%") }

  class Repository
    def initialize(connection = User)
      @connection = connection
    end

    delegate :all, :includes, :find, :search_by, to: :connection

    def ordered
      connection.order(creations_count: :desc)
    end

    def artists
      connection.includes(:avatar).artists
    end

    private

    attr_reader :connection
  end
end
