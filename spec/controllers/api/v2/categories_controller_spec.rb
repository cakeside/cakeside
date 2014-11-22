require 'rails_helper'

module Api
  module V2
    describe CategoriesController do
      describe "#index" do
        let!(:category) { create(:category) }

        it 'loads all the categories' do
          xhr :get, :index
          expect(assigns(:categories)).to match_array([category])
        end
      end

      describe "#show" do
        let!(:other_category) { create(:category) }
        let!(:category) { create(:category) }

        it 'loads the specified category' do
          xhr :get, :show, id: category.id
          expect(assigns(:category)).to eql(category)
        end
      end
    end
  end
end
