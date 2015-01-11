class Category < ActiveRecord::Base
  has_many :creations
  default_scope -> { order(:slug) }

  scope :by_slug, ->(category) do
    find_by(slug: category.downcase.parameterize)
  end

  def to_param
    slug
  end
end
