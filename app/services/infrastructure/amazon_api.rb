class AmazonAPI
  attr_reader :client

  def initialize(client = ASIN::Client.instance)
    @client = client
  end

  def search(query)
    return [] if query.blank?
    client.search(Keywords: query, SearchIndex: :Kitchen, Sort: :salesrank)
  end
end
