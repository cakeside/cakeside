require 'rails_helper'
module Admin
  describe ProductsController do 
    describe "#create" do
      let(:admin) { create(:admin)}

      before :each do
        http_login(admin)
      end

      it "creates new tool" do
        post :create, {:name=>"pan", :asin=>"34234"}

        expect(Tool.count).to eql(1)
        expect(Tool.first.name).to eql("pan")
        expect(Tool.first.asin).to eql("34234")
      end

      it "redirects back to the detail page" do
        post :create, {name: 'blah', asin: 'blah' }
        expect(response).to redirect_to(admin_products_path('blah'))
      end
    end
  end
end
