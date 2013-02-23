# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
unless Category.any? 
    #Add 5 categories 1)Cake 2)Cupcake 3)Cake Pop 4) Cookie 5)Other
  Category.create(:name => 'Cake', :slug => 'cake')
  Category.create(:name => 'Cup Cake', :slug => 'cup-cake')
  Category.create(:name => 'Cake Pop', :slug => 'cake-pop')
  Category.create(:name => 'Cookie', :slug => 'cookie')
  Category.create(:name => 'Other', :slug => 'other')
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
