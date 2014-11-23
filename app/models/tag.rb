class Tag
  def self.unique_tags
    ActsAsTaggableOn::Tag
      .joins(:taggings)
      .where(taggings: { context: 'tags' })
      .order(:name)
      .uniq
  end
end
