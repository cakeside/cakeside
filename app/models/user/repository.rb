class User
  scope :artists, ->{ where('creations_count > 0').order(creations_count: :desc) }
  scope :search_by, ->(query) { query.blank? ? self.all : where('name like :query or email like :query', query: "#{query}%") }

  class Repository < SimpleDelegator
    def initialize(connection = User)
      @connection = connection
      super(connection)
    end

    def ordered
      connection.order(creations_count: :desc)
    end

    def artists
      connection.includes(:avatar).artists
    end

    def search_with(params)
      artists
    end

    private

    attr_reader :connection
  end
end
