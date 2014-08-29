require 'rails_helper'

describe TutorialsController do
  let(:user){ create(:user) }

  before { http_login(user) }

  describe "#index" do
    let(:tutorial) { create(:tutorial) }

    before :each do
      user.tutorials << tutorial
      get :index
    end

    it "assigns all tutorials as @tutorials" do
      assigns(:tutorials).should include(tutorial)
    end
  end

  describe "#show" do
    let(:tutorial) { create(:tutorial) }

    before :each do
      user.tutorials << tutorial
      get :show, :id => tutorial.to_param
    end

    it "assigns the requested tutorial" do
      assigns(:tutorial).should == tutorial
    end
  end
end
