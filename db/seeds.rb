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

#ALL PURPOSE CAKE PAN
#Angel Food Cake Pan 6"
#Angel Food Cake Pan 7"
#Angel Food Cake Pan 8"
#Angel Food Cake Pan 10"
#Bundt/Kugelhopf 8.5"
#Cheesecake Pan Square 4" x 4" x 2"
#Cheesecake Pan Square 6" x 6" x 2"
#Cheesecake Pan Square 8" x 8" x 2"
#Cheesecake Pan Round 2" x 2"
#Cheesecake Pan Round 2.5" x 2"
#Cheesecake Pan Round 3" x 2"
#Cheesecake Pan Round 3" x 3"
#Cheesecake Pan Round 4" x 2"
#Cheesecake Pan Round 4" x 3"
#Cheesecake Pan Round 5" x 2"
#Cheesecake Pan Round 5" x 3"
#Cheesecake Pan Round 6" x 2"
#Cheesecake Pan Round 6" x 3"
#Cheesecake Pan Round 7" x 2"
#Cheesecake Pan Round 7" x 3"
#Cheesecake Pan Round 8" x 2"
#Cheesecake Pan Round 8" x 3"
#Cheesecake Pan Round 9" x 2"
#Cheesecake Pan Round 9" x 3"
#Cheesecake Pan Round 10" x 2"
#Cheesecake Pan Round 10" x 3"
#Heart Pan 6" x 2" 
#Heart Pan 8" x 2" 
#Heart Pan 9" x 2" 
#Heart Pan 10" x 2" 
#Heart Pan 10.25" x 2"
#Heart Pan 12" x 2" 
#Heart Pan 14" x 2" 
#Heart Pan 16" x 2" 
#Heart Pan 6 Cavity 2.25" x 1.25"
#Hexagon Pan 6" x 2"
#Hexagon Pan 9" x 2"
#Hexagon Pan 12" x 2"
#Hexagon Pan 15" x 2"
#Loaf Pan 9 1/4" x 5 1/4" x 2 3/4"
#Long Loaf Pan 16" x 4" x 4 1/2"
#Mini Angel Pan 4"
#Mini Angel Pan 4 1/2" x 2"
#Mini Fluted Pan 4"
#Mini Fluted Mold Pan 6 Cavity 4"cakes
#Mini Fluted Mold Pan 12 Cavity 4"cakes
#Mini Fluted Tube Pan 4"
#Mini Fluted Tube Pan 4 3/8" x 2"
#Mini Heart Pan 4"
#Mini Heart Pan 6 Cavity3 5/8: x 3 1/2" x 1"
#Mini Loaf Pan  5 3/4" x 3" x 2"
#Mini Ring Mold Fancy Pan
#Mini Round Pan 4" 
#Muffin Pan 12 Cup Mini Muffin
#Muffin Pan 24 Cup Mini Muffin
#Muffin Pan 6 Cup 3"
#Muffin Pan 12 cup 3 " 
#Muffin Pan 6 Cup King Size
#Muffin Pan 6 Cup Jumbo 4" x 2"
#Oval Pan 7 3/4" x 5 5/8" x 2"
#Oval Pan 10 3/4" x 7 5/8" x 2"
#Oval Pan 13" x 9 7/8" x 2"
#Oval Pan 16 1/2" x 12 3/8" x 2"
#Pannetone Pan 7" x 4"
#Pannetone Pan 9" x 6"
#Rectangular Pan 7" x 11" x 2"
#Rectangular Pan 7" x 11" x 3"
#Rectangular Pan 9" x 13" x 2"
#Rectangular Pan 9" x 13" x 3"
#Rectangular Pan 11" x 15" x 2"
#Rectangular Pan 11" x 15" x 3"
#Rectangular Pan 12" x 18" x 2"
#Rectangular Pan 12" x 18" x 3"
#Ring Mold Pan  5.25" x 2.25"
#Ring Mold Pan  7" x 2.25"
#Ring Mold Pan  8.75" x 2.25"
#Ring Mold Fancy Pan 10"
#Round Cake Pan 2" x 2" 
#Round Cake Pan 2" x 3" 
#Round Cake Pan 3" x 2" 
#Round Cake Pan 3" x 3" 
#Round Cake Pan 4" x 2" 
#Round Cake Pan 4" x 3" 
#Round Cake Pan 5" x 2" 
#Round Cake Pan 5" x 3" 
#Round Cake Pan 6" x 2" 
#Round Cake Pan 6" x 3" 
#Round Cake Pan 7" x 2" 
#Round Cake Pan 7" x 3" 
#Round Cake Pan 8" x 2" 
#Round Cake Pan 8" x 3" 
#Round Cake Pan 9" x 2" 
#Round Cake Pan 9" x 3" 
#Round Cake Pan 10" x 2"
#Round Cake Pan 10" x 3"
#Round Cake Pan 12" x 2 "
#Round Cake Pan 12" x 3"
#Round Cake Pan 14" x 2 "
#Round Cake Pan 14" x 3"
#Round Cake Pan 16" x 2"
#Round Cake Pan 16" x 3"
#Round Cake Pan 18" x 3"
#Sheet Cake Pan 9" x 13" x 2"
#Sheet Cake Pan 11" x 15" x 2"
#Sheet Cake Pan 12" x 18" x 2"
#Square Cake Pan 3" x 3" x 2"
#Square Cake Pan 3" x 3" x 3"
#Square Cake Pan 4" x 4" x 2"
#Square Cake Pan 4" x 4" x 3"
#Square Cake Pan 5" x 5" x 2"
#Square Cake Pan 5" x 5" x 3"
#Square Cake Pan 6" x 6" x 2"
#Square Cake Pan 6" x 6" x 3"
#Square Cake Pan 7" x 7" x 2"
#Square Cake Pan 7" x 7" x 3"
#Square Cake Pan 8" x 8" x 2"
#Square Cake Pan 8" x 8" x 3"
#Square Cake Pan 9" x 9" x 2"
#Square Cake Pan 9" x 9" x 3"
#Square Cake Pan 10" x 10" x 2"
#Square Cake Pan 10" x 10" x 3"
#Square Cake Pan 12" x 12" x 2"
#Square Cake Pan 12" x 12" x 3"
#Square Cake Pan 14" x 14" x 2"
#Square Cake Pan 14" x 14" x 3"
#Square Cake Pan 16" x 16" x 2"
#Square Cake Pan 16" x 16" x 3"
#Square Cake Pan 18" x 18" x 2"
#Square Cake Pan 18" x 18" x 3"
#Tart/Quche Pan 9" x 1 1/8"
#WILTON SPECIALITY SHAPED PANS
#1 Cake Pan
#3-D Bunny Pan
#3-D Cruiser Cake Pan
#3-D Egg Pan
#3-D Rubber Ducky Pan 
#Airplane Pan
#Antoinette Pan
#Baby Buggy Pan
#Ballerina Bear Pan
#Baseball Mitt Pan
#Belle Pan
#Bunny Pan
#Butterfly Pan
#Buzz Lightyear Pan
#Carebear Pan
#Cars Pixar Pan
#Cascade Pan
#Checkerboard Cake Pan
#Choo-Choo Train Pan
#Cross Pan
#Crown Pan
#Crown of Hearts Pan
#Cupcake Pan
#Dancing Daisy Pan
#Dinosaur Pan
#Doughnut Pan 6 Cavitiy
#Doughnut Twist Pan 6 Cavitiy
#Dump Truck Pan Elephant Cake Pan
#Elephant Pan
#Elmo Face Pan
#Enchanted Castle Pan
#Fanci-Fill Cake Pan
#Fire Truck Pan
#First and Ten Football Pan
#Football Pan
#Giant Cupcake Pan
#Gift Pan
#Gingerbread House Pan Mold
#Graduation Cap Pan
#Guitar Pan
#Half Ball Pan 3.5" x 1 3/4" 
#Half Ball Pan 6 1/4" x 3 1/8" 
#Hannah Montana Pan
#Helmet Pan
#Horseshoe Pan
#Jack-O-Lantern Pan
#Lady Bug Pan
#Little Mermaid Pan
#Mickey Mouse Head pan
#Mini Ball Pan
#Mini Bunny Pan
#Mini Coffin Pan
#Mini Cupcakes Pan
#Mini Decorated Heart Pan
#Mini Decorated Egg Pan
#Mini Doughnut Pan 12 Cavitiy
#Mini Flower Cake Pan
#Mini Ghost Pan
#Mini Gingerbread Boy Pan
#Mini Gingerbread Boys and Trees Pan
#Mini Holiday Pan
#Mini Jack-O-Lantern Pan
#Mini Pie Harvest Pan
#Mini Pumpkins Pan
#Mini Pumpkin/Ghost Pan
#Mini Rose Pan
#Mini Skulls Pan
#Mini Snowflakes Pan
#Mini Snowman
#Mini Snowman & Mitten Pan
#Mini Snowman & Stocking Pan
#Mini Star Pan 6 Cavity 4 3/4" x 1 1/4"
#Mini Tasty-Fill Pan
#Mini Tulip Pan
#Mini Wonder Mold Pan 10" x 10" x 3" (4 x 3 1/2" x 3" cakes)
#Monkey Pan
#Noah's Ark Pan
#Paisley Pan 9" x 6" x 2"
#Paisley Pan 12 3/4" x 9" x 2"
#Paisley Pan 17" x 12" x 2"
#Party Hat Pan
#Party Pony Pan 
#Paw Print Pan
#Pennant Pan
#Perennial Pan
#Petal Pan 6" x 2"
#Petal Pan 9" x 2"
#Petal Pan 12" x 2"
#Petal Pan 15" x 2"
#Petite Jack-O-Lantern Pan
#Pillow Pan 6 3/4" x 6 3/4" x 2"
#Pillow Pan 10" x 10" x 2"
#Pillow Pan 13 1/4" x 13 1/4" x 2"
#Pirate Ship Pan
#Princess Carriage Pan
#Puzzle Cakes - Animals
#Puzzle Cakes - Transportation
#Queen of Hearts Pan
#Rocking Horse Pan
#Rubber Ducky Pan
#Skate Pan
#Shamrock Pan
#Snowflake Pan
#Soccer Ball Pan
#Spiderman Pan
#Spongebob Pan
#Sports Ball Pan
#Stand-Up Cuddly Bear Pan
#Stand-Up House Pan
#Stand-Up Lamb Pan
#Star Pan
#Stars and Stripes Pan
#Sunflower Pan
#SweetHeart Pan
#Tasty Fill Heart Pan
#Teddy Bear Pan
#Tinkerbell Pan
#Topping Off Success Pan
#Topsy Turvy Pan
#Tracktor Pan
#Train Pan
#Transformers Pan
#Tree Pan
#Tulip Pan
#Book Pan
#Wall E Pan
#Wonder Mold Kit
#NORDIC WARE SPECIALTY SHAPED PANS
#3-D Easter Bunny Pan
#3-D Santa Claus Pan
#3-D Spring Lamb Pan
#Backyard Bugs Pan
#Beehive Pan
#Bundt Castle Pan
#Bundt Cathedral Pan
#Bundt Fleur De Lis
#Bundt Heart Pan
#Bundt Holiday Wreath Pan
#Bundt Poinsettia Pan
#Bundt Sunflower Pan
#Crème Filled Wafer Cake Pan
#Donut Cake Pan
#Giant Cupcake
#Mini Garland Bundt Pan
#Mini Multi Bundt Pan
#Mini Pumpkin Muffin Pan
#Pirate Ship Pan
#Tractor Pan
#PETAL CRAFTS SPECIALTY SHAPED PANS
#3-D Medium Cupcake Pan
#Round Mini Topsy Turvy Pan Set
#Round Topsy Turvy 6", 8", 10", 12", 14" Pan Set
#Square Mini Topsy Turvy
#Quare Topsy Turvy 6", 8", 10", 12", 14" Pan Set
