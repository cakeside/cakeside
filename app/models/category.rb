class Category < ActiveRecord::Base
  has_many :creations
  default_scope -> { order(:name) }

  def to_param
    slug
  end
end
