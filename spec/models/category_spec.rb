require 'rails_helper'

describe Category do
  describe ".by_slug" do
    let!(:cookies) { create(:category, slug: 'cookies') }
    let!(:cup_cakes) { create(:category, slug: 'cup-cakes') }
    let!(:cakes) { create(:category, slug: 'cakes') }

    it 'finds by slug' do
      expect(Category.by_slug('cakes')).to eql(cakes)
      expect(Category.by_slug('CAKES')).to eql(cakes)
      expect(Category.by_slug('Cakes')).to eql(cakes)
    end
  end

  describe "#to_param" do
    subject { Category.new(name: 'The Cakes', slug: 'cakes') }

    it 'returns the slug as the id' do
      expect(subject.to_param).to eql('cakes')
    end
  end

  describe ".all" do
    let!(:cookies) { create(:category, slug: 'cookies') }
    let!(:cup_cakes) { create(:category, slug: 'cup-cakes') }
    let!(:cakes) { create(:category, slug: 'cakes') }

    it 'loads categories ordered by name' do
      expect(Category.all.to_a).to eql([cakes, cookies, cup_cakes])
    end
  end
end
