require "rails_helper"

describe Api::V1::CakesController do
  render_views

  context "when signed in" do
    let(:user) { create(:user) }

    before :each do
      api_login(user)
    end

    describe "#index" do
      let!(:my_cake) { create(:creation) }
      let!(:other_cake) { create(:creation) }

      before :each do
        user.creations << my_cake
        get :index, xhr: true
      end

      it "returns all of my cakes" do
        expect(assigns(:cakes)).to match_array([my_cake])
      end

      it "does not return any other cakes" do
        expect(assigns(:cakes)).to_not include(other_cake)
      end
    end

    describe "#show" do
      let!(:cake) { create(:creation) }

      before :each do
        user.creations << cake
        get :show, params: { id: cake.id }, xhr: true
      end

      it "loads a specific cake" do
        expect(assigns(:cake)).to eql(cake)
      end
    end

    describe "#create" do
      let(:category) { create(:category) }

      it "creates a new project" do
        post :create, params: { cake: { name: "new-cake", category_id: category.id } }, xhr: true

        expect(Creation.count).to eql(1)
        expect(Creation.first.name).to eql("new-cake")
        expect(Creation.first.category).to eql(category)
        expect(Creation.first.user).to eql(user)
      end
    end

    describe "#update" do
      let(:cake) { create(:cake, user: user) }

      it "tags the cake" do
        tags = ["cake", "cookies", "yummy"]
        patch :update, params: { id: cake.id, cake: { tags: tags.join(", ") } }, xhr: true

        cake.reload
        expect(cake.tags.pluck(:name)).to match_array(tags)
      end

      it "updates the description" do
        new_story = "what is the haps on the craps"
        patch :update, params: { id: cake.id, cake: { story: new_story } }, xhr: true

        cake.reload
        expect(cake.story).to eql(new_story)
      end

      it "updates the category" do
        category = create(:category)
        patch :update, params: { id: cake.id, cake: { category_id: category.id } }, xhr: true

        cake.reload
        expect(cake.category).to eql(category)
      end
    end

    describe "#destroy" do
      let!(:cake) { create(:creation) }

      before :each do
        user.creations << cake
        delete :destroy, params: { id: cake.id }, xhr: true
      end

      it "deletes the specified cake" do
        expect(Creation.exists?(cake.id)).to be_falsey
      end

      it "returns an empty json response" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eql(cake.id)
      end
    end
  end
end
