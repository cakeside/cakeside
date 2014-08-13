require 'rails_helper'

describe TutorialsController do
  def valid_attributes
    {:url => 'http://blah.com', :heading => "hello world"}
  end

  let(:user){ create(:user) }

  before (:each) do
    http_login(user)
  end

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

  describe "#new" do
    it "assigns a new tutorial as @tutorial" do
      get :new
      assigns(:tutorial).should be_a_new(Tutorial)
    end
  end

  describe "#edit" do
    let(:tutorial) { create(:tutorial) }

    it "assigns the requested tutorial as @tutorial" do
      user.tutorials << tutorial
      get :edit, {:id => tutorial.to_param}
      assigns(:tutorial).should eq(tutorial)
    end
  end

  describe "#create" do
    describe "with valid params" do
      before :each do
        post :create, {:tutorial => {:url => 'http://blah.com', :heading => "hello world"} }
      end

      it "creates a new Tutorial" do
        Tutorial.count.should == 1
      end

      it "assigns a newly created tutorial as @tutorial" do
        assigns(:tutorial).should be_a(Tutorial)
        assigns(:tutorial).should be_persisted
        assigns(:tutorial).url.should == 'http://blah.com'
        assigns(:tutorial).heading.should == 'hello world'
      end

      it "redirects to the created tutorial" do
        response.should redirect_to(my_dashboard_path)
      end
    end

    describe "with invalid params" do
      before :each do
        Tutorial.any_instance.stub(:save).and_return(false)
        post :create, {:tutorial => {:url => '', :heading => ''}}
      end

      it "assigns a newly created but unsaved tutorial as @tutorial" do
        assigns(:tutorial).should be_a_new(Tutorial)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end

      it "should display an error" do
        flash[:error].should_not be_nil
      end
    end
  end

  describe "#patch" do
    describe "with valid params" do
      let(:tutorial) { create(:tutorial) }

      before :each do
        user.tutorials << tutorial
        patch :update, :id => tutorial.to_param, :tutorial => { :url => 'http://blah', :heading => 'headless'}
      end

      it "assigns the requested tutorial" do
        assigns(:tutorial).should == tutorial
        assigns(:tutorial).url.should == 'http://blah'
        assigns(:tutorial).heading.should == 'headless'
      end

      it "redirects to the tutorial" do
        response.should redirect_to(tutorial.reload)
      end
    end

    describe "with invalid params" do
      let(:tutorial) { create(:tutorial) }
      before :each do
        user.tutorials << tutorial
        Tutorial.any_instance.stub(:save).and_return(false)
        patch :update, {:id => tutorial.to_param, :tutorial => {:url => "", :heading => ""}}
      end

      it "assigns the tutorial as @tutorial" do
        assigns(:tutorial).should eq(tutorial)
      end

      it "re-renders the 'edit' template" do
        response.should render_template("edit")
      end
    end
  end

  describe "#destroy" do
    let(:tutorial) { create(:tutorial) }

    before :each do
      user.tutorials << tutorial
      delete :destroy, {:id => tutorial.to_param}
    end

    it "destroys the requested tutorial" do
      Tutorial.count.should == 0
    end

    it "redirects to the tutorials list" do
      response.should redirect_to(my_dashboard_path)
    end
  end
end
