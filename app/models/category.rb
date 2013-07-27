class Category < ActiveRecord::Base
  has_and_belongs_to_many :creations, :join_table => 'creations_categories'
  #attr_accessible :name, :slug
  #default_scope -> { order(:name) }

  def to_param
    slug
  end
end
