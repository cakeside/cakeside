require "rails_helper"

module Api
  module V2
    describe CategoriesController do
      render_views

      describe "#index" do
        let!(:category) { create(:category) }

        it "loads all the categories" do
          get :index, xhr: true
          expect(assigns(:categories)).to match_array([category])
        end
      end

      describe "#show" do
        let!(:other_category) { create(:category) }
        let!(:category) { create(:category) }

        it "loads the specified category" do
          get :show, params: { id: category.id }, xhr: true
          expect(assigns(:category)).to eql(category)
        end
      end
    end
  end
end
