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
      filter_by(search_filters_for(params))
    end

    private

    attr_reader :connection

    def search_filters_for(params)
      query_builder_for(params) do |builder|
        builder.if_present(:artists) do |relation, _|
          relation.artists
        end
        builder.if_present(:q) do |relation, search_term|
          relation.search_by(search_term)
        end
        builder.if_present(:sort) do |relation, direction|
          case direction.try(:downcase)
          when 'oldest'
            relation.oldest
          when 'newest'
            relation.newest
          else
            relation.by_cakes
          end
        end
        builder.if_missing(:sort) do |relation, direction|
          relation.order(creations_count: :desc)
        end
      end
    end
  end
end
