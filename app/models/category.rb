class Category < ActiveRecord::Base
  has_and_belongs_to_many :creations, :join_table => 'creations_categories'
end
