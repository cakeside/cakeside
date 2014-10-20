class User
  include Queryable
  scope :artists, ->{ includes(:avatar).where('creations_count > 0') }
  scope :search_by, ->(query) { query.blank? ? all : where('upper(users.name) LIKE :query OR upper(users.email) LIKE :query', query: "#{query.upcase}%") }
  scope :oldest, ->{ order(created_at: :asc) }
  scope :newest, ->{ order(created_at: :desc) }
  scope :by_cakes, ->{ order(creations_count: :desc) }

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
        ->(users){ params[:artists].present? ? users.artists : all },
        ->(users){ users.search_by(params[:q]) },
        sort_using(params[:sort])
      ]
    end

    def sort_using(sort_by)
      case sort_by.try(:downcase)
      when 'oldest'
        ->(users) { users.oldest }
      when 'newest'
        ->(users) { users.newest }
      else
        ->(users) { users.by_cakes }
      end
    end
  end
end
