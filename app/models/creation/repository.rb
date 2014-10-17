class Creation
  scope :tagged, ->(tag) { tagged_with([tag]).where('photos_count > 0') }

  class Repository < SimpleDelegator
    def initialize(connection = Creation)
      @connection = connection
      super(connection)
    end

    def tagged(tag)
      connection.includes([:user, :photos]).tagged(tag)
    end

    private

    attr_reader :connection
  end
end
