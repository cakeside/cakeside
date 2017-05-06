class Creation
  include Queryable
  scope :tagged, ->(tag) { tagged_with([tag]).where('photos_count > 0') }
  scope :published, ->{ joins(:photos).where(photos: { image_processing: nil }) }
  scope :search, ->(query) { where(["UPPER(creations.name) LIKE :query OR UPPER(creations.story) LIKE :query", { query: "%#{query.upcase}%" }]) }
  scope :sorted_by, ->(direction) do
    order(created_at: "oldest" == direction ? :asc : :desc)
  end

  class Repository < SimpleDelegator
    def initialize(connection = Creation)
      @connection = connection
      super(connection)
    end

    def tagged(tag)
      connection.includes([:user, :photos]).tagged(tag)
    end

    def search(query)
      connection.includes(:user, :photos).search(query)
    end

    def search_with(params)
      filter_by(search_filters_for(params))
    end

    private

    attr_reader :connection

    def search_filters_for(params)
      query_builder_for(params) do |builder|
        builder.always do |relation|
          relation.published
        end
        builder.if_present(:category) do |relation, category|
          relation.where(category: Category.by_slug(category))
        end
        builder.if_present(:q) do |relation, query|
          relation.search(query)
        end
        builder.if_present(:tags) do |relation, tags|
          relation.tagged(tags.downcase.parameterize)
        end
        builder.if_present(:sort) do |relation, sort_order|
          relation.sorted_by(sort_order)
        end
      end
    end
  end
end
