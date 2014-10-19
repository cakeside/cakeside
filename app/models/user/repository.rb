class User
  include Queryable
  scope :artists, ->{ includes(:avatar).where('creations_count > 0').order(creations_count: :desc) }
  scope :search_by, ->(query) { query.blank? ? all : where('upper(users.name) LIKE :query OR upper(users.email) LIKE :query', query: "#{query.upcase}%") }

  class Repository < SimpleDelegator
    def initialize(connection = User)
      @connection = connection
      super(connection)
    end

    def ordered
      connection.order(creations_count: :desc)
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
