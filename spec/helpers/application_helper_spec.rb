require "rails_helper"

describe ApplicationHelper do
  describe "#backbone_collection_for" do
    it 'returns a script with the backbone collection' do
      result = helper.backbone_collection_for(Category.all)
      expect(result).to include("AutoCollection.install")
      expect(result).to include("Category")
      expect(result).to include("categories")
    end

    it 'escapes namespaces correctly' do
      result = helper.backbone_collection_for(ActsAsTaggableOn::Tag.all)
      expect(result).to include("AutoCollection.install")
      expect(result).to include("Tag")
      expect(result).to include("acts_as_taggable_on_tags")
    end
  end
end
