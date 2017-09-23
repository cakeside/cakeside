require 'rails_helper'

module Api
  module V1
    describe CategoriesController do
      render_views

      describe "#index" do
        it 'loads all the categories' do
          get :index, xhr: true
          expect(assigns(:categories)).to match_array(Category.all)
        end
      end
    end
  end
end
