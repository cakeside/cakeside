require 'rails_helper'

module Api
  module V2
    describe CakesController do
      render_views

      describe "#index" do
        let!(:cakes) { create(:category, slug: 'cakes') }
        let!(:cookies) { create(:category, slug: 'cookies') }
        let!(:cake) { create(:published_cake, name: 'cake', category: cakes) }
        let!(:cookie) { create(:published_cake, name: 'cookie', category: cookies) }
        let!(:unpublished_cake) { create(:cake, name: 'unpublished', category: cakes) }

        it 'returns all published cakes' do
          xhr :get, :index
          expect(assigns(:cakes)).to match_array([cake, cookie])
        end

        it 'returns all cakes in the category' do
          xhr :get, :index, category: cookie.category.slug
          expect(assigns(:cakes)).to match_array([cookie])
        end

        it 'returns all cakes matching the search query' do
          xhr :get, :index, q: cake.name[0..2]
          expect(assigns(:cakes)).to match_array([cake])
        end

        it 'returns all cakes tagged with the tag' do
          cake.tag_list = 'cakes'
          cake.save!

          xhr :get, :index, tags: 'cakes'
          expect(assigns(:cakes)).to match_array([cake])
        end
      end

      describe "#show" do
        let!(:cake) { create(:published_cake) }

        it 'loads the cake' do
          xhr :get, :show, id: cake.id
          expect(assigns(:cake)).to eql(cake)
        end
      end
    end
  end
end
