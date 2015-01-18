class Creation
  include Queryable
  scope :tagged, ->(tag) { tagged_with([tag]).where('photos_count > 0') }
  scope :published, ->{ joins(:photos).where(photos: { image_processing: nil }) }
  scope :search, ->(query) { where(["UPPER(creations.name) LIKE :query OR UPPER(creations.story) LIKE :query", { query: "%#{query.upcase}%" }]) }

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
      all_matching(search_filters_for(params))
    end

    private

    attr_reader :connection

    def search_filters_for(params)
      [
        ->(cakes) { cakes.published },
        ->(cakes) { params[:category].blank? ? cakes.all : cakes.where(category: Category.by_slug(params[:category])) },
        ->(cakes) { params[:q].blank? ? cakes.all : cakes.search(params[:q]) },
        ->(cakes) { cakes.order(created_at: sort(params)) },
        ->(cakes) { params[:tags].blank? ? cakes.all : cakes.tagged(params[:tags].downcase.parameterize) },
      ]
    end

    def sort(params)
      params[:sort] == "oldest" ? :asc : :desc
    end
  end
end
