class Creation
  include Filterable
  scope :tagged, ->(tag) { tagged_with([tag]).where('photos_count > 0') }
  scope :published, ->() { unscoped.distinct.includes(:user, :photos).joins(:photos).where('photos.image_processing' => nil) }

  class Repository < SimpleDelegator
    def initialize(connection = Creation)
      @connection = connection
      super(connection)
    end

    def tagged(tag)
      connection.includes([:user, :photos]).tagged(tag)
    end

    def search(query)
      connection.includes(:user, :photos).where(["upper(name) like :query OR upper(story) like :query", { query: "%#{query.upcase}%" }])
    end

    private

    attr_reader :connection
  end
end
