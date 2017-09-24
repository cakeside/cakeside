require "rails_helper"

describe ApplicationHelper do
  describe "#backbone_collection_for" do
    it 'returns a script with the backbone collection' do
      categories = Category.all
      result = helper.backbone_collection_for(categories)
      expect(result).to include("csx.Categories")
      expect(result).to include("Backbone.Collection")
    end

    it 'escapes namespaces correctly' do
      tags = ActsAsTaggableOn::Tag.all
      result = helper.backbone_collection_for(tags)
      expect(result).to include("csx.Tags")
      expect(result).to include("Backbone.Collection")
    end
  end
end
