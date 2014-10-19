class User
  include Queryable
  scope :artists, ->{ where('creations_count > 0').order(creations_count: :desc) }
  scope :search_by, ->(query) { query.blank? ? self.all : where('users.name like :query or users.email like :query', query: "#{query}%") }

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
      all_matching(search_filters_for(params))
    end

    private

    attr_reader :connection

    def search_filters_for(params)
      [
        ->(users){ users.artists },
        ->(users){ params[:q].blank? ? users.all : users.search_by(params[:q]) },
      ]
    end
  end
end
