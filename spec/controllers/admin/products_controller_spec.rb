require 'rails_helper'

module Admin
  describe ProductsController do 
    let(:admin) { create(:admin)}

    before :each do
      http_login(admin)
    end

    describe "#show" do
      let(:product_api) { double(find: true) }

      before :each do
        controller.stub(:product_api).and_return(product_api)
      end

      it 'loads the product details from amazon' do
        asin = 'asin'
        product = "product"
        product_api.stub(:find).with(asin).and_return(product)

        get :show, id: asin

        expect(assigns(:product)).to eql(product)
      end

      context "when the tool has been added to the toolbox" do
        let(:tool) { create(:tool) }

        it "loads the tool" do
          get :show, id: tool.asin
          expect(assigns(:tool)).to eql(tool)
        end
      end

      context "when the tool is not in the toolbox" do
        it "does not load a tool" do
          get :show, id: "not_added"
          expect(assigns(:tool)).to be_nil
        end
      end
    end

    describe "#create" do
      it "creates new tool" do
        post :create, {:name=>"pan", :asin=>"34234"}

        expect(Tool.count).to eql(1)
        expect(Tool.first.name).to eql("pan")
        expect(Tool.first.asin).to eql("34234")
      end

      it "redirects back to the detail page" do
        post :create, {name: 'blah', asin: 'blah' }
        expect(response).to redirect_to(admin_product_path('blah'))
      end
    end
  end
end
