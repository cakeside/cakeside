class MigrateCategoriesToTags < ActiveRecord::Migration
  def up
    ["Fondant", "Butter Cream", "Tiered", "3D", "Birthday", "Wedding", "Holiday", "Theme", "Anniversary", "Baby Shower", "Naughty Cakes"].each do |category|
      Creation.joins(:categories).where(:categories => {:name => category }).each do |creation|
        local_creation = Creation.find(creation.id)
        local_tags = local_creation.tags.map{ |tag| tag.name }
        local_tags.push(category)
        creation.user.tag(local_creation, :with => local_tags, :on => :tags)
        local_creation.save!
      end
      Category.find_by_name(category).destroy if Category.find_by_name(category)
    end
  end

  def down
  end
end
