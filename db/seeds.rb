# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
unless Category.any? 
  Category.create(:name => 'Fondant', :slug => 'fondant')
  Category.create(:name => 'Butter Cream', :slug => 'butter-cream')
  Category.create(:name => 'Cup Cake', :slug => 'cup-cake')
  Category.create(:name => 'Tiered', :slug => 'tiered')
  Category.create(:name => '3D', :slug => '3d')
  Category.create(:name => 'Birthday', :slug => 'birthday')
  Category.create(:name => 'Wedding', :slug => 'wedding')
  Category.create(:name => 'Holiday', :slug => 'holiday')
  Category.create(:name => 'Theme', :slug => 'theme')
  Category.create(:name => 'Anniversary', :slug => 'anniversary')
  Category.create(:name => 'Baby Shower', :slug => 'baby-shower')
end
unless Interest.any? 
  Interest.create(:name => 'I own a bakery')
  Interest.create(:name => 'I work for a bakery')
  Interest.create(:name => 'I sell baking supplies')
  Interest.create(:name => 'I teach baking/decorating class')
  Interest.create(:name => 'My business is from home')
  Interest.create(:name => 'Baking is my hobby')
  Interest.create(:name => 'Just Looking')
end
