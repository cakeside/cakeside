class AmazonAPI
  attr_reader :client

  def initialize(client = ASIN::Client.instance)
    @client = client
  end

  def search(query)
    return [] if query.blank?
    results = client.search(Keywords: query, SearchIndex: :Kitchen, Sort: :salesrank, Availability: :Available, MerchantId: :Amazon)
    results.map { |x| AmazonProduct.new(x) }
  end
end

class AmazonProduct
  attr_reader :item
  delegate :asin, :detail_page_url, :item_attributes, :item_links, to: :item

  def initialize(item)
    @item = item
  end

  def title
    item.item_attributes.title
  end

  def url
    item.detail_page_url
  end

  def manufacturer
    item.item_attributes.manufacturer
  end

  def category
    item.item_attributes.product_group
  end

  def links
    item.item_links.item_link.map do |link|
      OpenStruct.new(description: link.description, url: link.url)
    end
  end
end
