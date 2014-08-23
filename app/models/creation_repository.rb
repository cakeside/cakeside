class CreationRepository
  delegate :find, to: :connection

  def initialize(connection = Creation)
    @connection = connection
  end

  def search(query)
    connection.includes(:user, :photos).where(["upper(name) like :query OR upper(story) like :query", { query: "%#{query.upcase}%" }])
  end

  def visible_creations
    connection.distinct.includes(:user, :photos).joins(:photos).where('photos.image_processing' => nil)
  end

  private

  attr_reader :connection
end
