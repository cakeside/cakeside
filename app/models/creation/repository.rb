class Creation
  include Filterable
  scope :tagged, ->(tag) { tagged_with([tag]).where('photos_count > 0') }
  scope :published, ->() { unscoped.distinct.includes(:user, :photos).joins(:photos).where('photos.image_processing' => nil) }
  scope :search, ->(query) { where(["upper(creations.name) like :query OR upper(creations.story) like :query", { query: "%#{query.upcase}%" }]) }

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

    private

    attr_reader :connection
  end
end
