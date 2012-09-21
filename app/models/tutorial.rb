class Tutorial < ActiveRecord::Base
  attr_accessible :description, :heading, :url, :image_url
  belongs_to :user
  acts_as_taggable

  def to_param
    "#{id}-#{heading.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
