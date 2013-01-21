class Tutorial < ActiveRecord::Base
  attr_accessible :description, :heading, :url, :image_url, :user_id, :author, :author_url
  belongs_to :user
  acts_as_taggable

  default_scope order("created_at DESC")

  def to_param
    "#{id}-#{heading.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
