class Category < ActiveRecord::Base
  has_many :creations
  default_scope -> { order(:slug) }

  scope :by_slug, ->(category) { find_by(slug: category.downcase)}

  def to_param
    slug
  end
end
