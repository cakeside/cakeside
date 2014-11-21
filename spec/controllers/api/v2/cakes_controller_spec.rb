require 'rails_helper'

module Api
  module V2
    describe CakesController do
      describe "#index" do
        let!(:cake) { create(:published_cake) }

        it 'returns all cakes in the page' do
          xhr :get, :index
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
