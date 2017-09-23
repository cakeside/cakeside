require "rails_helper"

describe Api::V1::TutorialsController do
  render_views
  let(:user) { create(:user) }

  before :each do
    api_login(user)
  end

  describe "#index" do
    let!(:my_tutorial) { create(:tutorial, user: user) }
    let!(:other_tutorial) { create(:tutorial) }

    it "returns the users tutorials" do
      get :index, xhr: true
      expect(assigns(:tutorials)).to match_array([my_tutorial])
    end
  end

  describe "#create" do
    it "creates a new tutorial" do
      attributes = {
        url: "https://twitter.com/",
        image_url: "https://abs.twimg.com/a/img/t1/lemon.jpg",
        heading: "Twitter",
        description: "Connect with your friends - and other fascinating people",
        tags: "cake,cookie",
      }
      post :create, params: { tutorial: attributes }, xhr: true

      expect(assigns(:tutorial)).to be_present
      expect(assigns(:tutorial).url).to eql(attributes[:url])
      expect(assigns(:tutorial).description).to eql(attributes[:description])
      expect(assigns(:tutorial).heading).to eql(attributes[:heading])
      expect(assigns(:tutorial).tags.count).to eql(2)
      expect(assigns(:tutorial).tags.pluck(:name)).to match_array(["cake", "cookie"])
    end
  end
end
