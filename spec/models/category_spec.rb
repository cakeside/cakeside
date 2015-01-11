require 'rails_helper'

describe Category do
  describe ".by_slug" do
    let!(:category) { create(:category, slug: 'cookies') }
    let!(:category) { create(:category, slug: 'cup-cakes') }
    let!(:category) { create(:category, slug: 'cakes') }

    it 'finds by slug' do
      expect(Category.by_slug('cakes')).to eql(category)
      expect(Category.by_slug('CAKES')).to eql(category)
      expect(Category.by_slug('Cakes')).to eql(category)
    end
  end

  describe "#to_param" do
    subject { Category.new(name: 'The Cakes', slug: 'cakes') }

    it 'returns the slug as the id' do
      expect(subject.to_param).to eql('cakes')
    end
  end
end
