class CreationRepository
  delegate :find, to: :connection

  def initialize(connection = Creation)
    @connection = connection
  end

  def search(query)
    sql_search = "%#{query}%"
    connection.includes(:user).where("upper(name) like upper(?) OR upper(story) like upper(?)", sql_search, sql_search)
  end

  def visible_creations
    connection.distinct.includes(:user, :photos).joins(:photos).where('photos.image_processing' => nil)
  end

  private

  attr_reader :connection
end
