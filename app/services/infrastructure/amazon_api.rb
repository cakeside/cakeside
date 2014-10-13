class AmazonAPI
  attr_reader :client

  def initialize(client = ASIN::Client.instance)
    @client = client
  end

  def find(asin)
    client.lookup(asin).first
  end

  def search(query)
    return [] if query.blank?
    client.search(Keywords: query, SearchIndex: :Kitchen, Sort: :salesrank, Availability: :Available, MerchantId: :Amazon)
  end
end
