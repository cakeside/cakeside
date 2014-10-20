class Creation
  include Queryable
  scope :tagged, ->(tag) { tagged_with([tag]).where('photos_count > 0') }
  scope :published, ->() { unscoped.distinct.includes(:user, :photos).joins(:photos).where('photos.image_processing' => nil) }
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
        ->(cakes) { params[:category].blank? ? cakes.all : cakes.where(category: Category.find_by(slug: params[:category].downcase)) },
        ->(cakes) { params[:q].blank? ? cakes.all : cakes.search(params[:q]) },
        ->(cakes) { cakes.order(created_at: sort(params)) },
      ]
    end

    def sort(params)
      params[:sort] == "oldest" ? :asc : :desc
    end
  end
end
