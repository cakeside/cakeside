require "rails_helper"

module Api
  module V2
    describe CakesController do
      render_views

      describe "#index" do
        let!(:cakes) { create(:category, slug: "cakes") }
        let!(:cookies_category) { create(:category, slug: "cookies") }
        let!(:cake) { create(:published_cake, name: "cake", category: cakes) }
        let!(:cookie) do
          create(:published_cake, name: "cookie", category: cookies_category)
        end
        let!(:unpublished_cake) do
          create(:cake, name: "unpublished", category: cakes)
        end

        it "returns all published cakes" do
          get :index, xhr: true
          expect(assigns(:cakes)).to match_array([cake, cookie])
        end

        it "returns all cakes in the category" do
          get :index, params: { category: cookie.category.slug }, xhr: true
          expect(assigns(:cakes)).to match_array([cookie])
        end

        it "returns all cakes matching the search query" do
          get :index, params: { q: cake.name[0..2] }, xhr: true
          expect(assigns(:cakes)).to match_array([cake])
        end

        it "returns all cakes tagged with the tag" do
          cake.tag_list = "cakes"
          cake.save!

          get :index, params: { tags: "cakes" }, xhr: true
          expect(assigns(:cakes)).to match_array([cake])
        end
      end

      describe "#show" do
        let!(:cake) { create(:published_cake) }

        it "loads the cake" do
          get :show, params: { id: cake.id }, xhr: true
          expect(assigns(:cake)).to eql(cake)
        end
      end
    end
  end
end
