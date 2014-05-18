class CreationRepository
  def initialize(connection = Creation)
    @connection = connection
  end

  def search(query)
    sql_search = "%#{query}%"
    @connection.includes(:user).where("upper(name) like upper(?) OR upper(story) like upper(?)", sql_search, sql_search)
  end

  def visible_creations
    @connection.distinct.includes(:user).joins(:photos).where(is_restricted: false, 'photos.image_processing' => nil)
  end
end
