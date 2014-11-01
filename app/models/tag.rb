class Tag
  def self.unique_tags
    ActsAsTaggableOn::Tag
      .joins(:taggings)
      .where(taggings: { context: 'tags' })
      .order(:name)
      .pluck(:name)
      .uniq
  end

  def self.unique_tools
    #ActsAsTaggableOn::Tag
      #.joins(:taggings)
      #.where(taggings: { context: 'tools' })
      #.where(taggings: { taggable_type: Creation.name })
      #.order(:name)
      #.pluck(:name)
      #.uniq
    Tool.all
  end
end
