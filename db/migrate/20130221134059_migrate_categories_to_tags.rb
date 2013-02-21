class MigrateCategoriesToTags < ActiveRecord::Migration
  def up
    #Add 5 categories 1)Cake 2)Cupcake 3)Cake Pop 4) Cookie 5)Other
    ["Fondant", "Butter Cream", "Tiered", "3D", "Birthday", "Wedding", "Holiday", "Theme", "Anniversary", "Baby Shower", "Naughty Cakes"].each do |category|
      p category
      Creation.joins(:categories).where(:categories => {:name => category }).each do |creation|
        p "    #{creation.name} with #{category}"
        local_creation = Creation.find(creation.id)
        local_tags = local_creation.tags.map{ |tag| tag.name }
        local_tags.push(category)
        p "before #{local_tags}"
        creation.user.tag(local_creation, :with => local_tags, :on => :tags)
        p "after #{local_creation.tags}"
        local_creation.save!
      end
    end
  end

  def down
  end
end
