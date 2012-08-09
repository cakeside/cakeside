require 'spec_helper'

describe CreationsController do
  include Devise::TestHelpers

  let(:user){ FactoryGirl.build(:user) }
  let(:creation){ FactoryGirl.build(:creation) }

  def mock_creation(stubs={})
    @mock_creation ||= mock_model(Creation, stubs).as_null_object
  end

  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
  end

  describe "GET index" do
    it "assigns all creations as @creations" do
      relation = mock(ActiveRecord::Relation, :per => [mock_creation])
      Creation.stub(:page) { relation }
      get :index
      assigns(:creations).should eq([mock_creation])
    end
  end

  describe "GET show" do
    it "assigns the requested creation as @creation" do
      Creation.stub(:find).with("37") { mock_creation }
      get :show, :id => "37"
      assigns(:creation).should be(mock_creation)
    end
  end

  describe "GET new" do
    it "assigns a new creation as @creation" do
      Creation.stub(:new) { mock_creation }
      get :new
      assigns(:creation).should be(mock_creation)
    end
  end

  describe "GET edit" do
    it "assigns the requested creation as @creation" do
      user.stub(:creations){ mock_creation }
      get :edit, :id => "37"
      assigns(:creation).should be(mock_creation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created creation as @creation" do
        user.stub(:creations){ mock_creation(:save => true) }
        post :create, :creation => {'these' => 'params'}
        assigns(:creation).should be(mock_creation)
      end

      it "redirects to the created creation" do
        user.stub(:creations){ mock_creation(:save => true) }
        post :create, :creation => {}
        #response.should redirect_to(creation_url(mock_creation))
        expect(response).to render_template("crop")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved creation as @creation" do
        user.stub(:creations){ mock_creation(:save => false) }
        post :create, :creation => {'these' => 'params'}
        assigns(:creation).should be(mock_creation)
      end

      it "re-renders the 'new' template" do
        user.stub(:creations){ mock_creation(:save => false) }
        post :create, :creation => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested creation" do
        user.stub(:creations){ mock_creation }
        mock_creation.should_receive(:update_attributes).with({'these' => 'params', 'category_ids' => []})
        put :update, :id => "37", :creation => {'these' => 'params'}
      end

      it "assigns the requested creation as @creation" do
        creation = mock_creation(:update_attributes => true, :category_ids => [])
        user.stub(:creations){ creation }
        put :update, :id => "1", :creation => { :category_ids => [] }
        assigns(:creation).should be(creation)
      end

      it "redirects to the creation" do
        user.stub(:creations){ mock_creation(:update_attributes => true) }
        put :update, :id => "1", :creation => { :category_ids => [] }
        response.should redirect_to(creation_url(mock_creation))
      end
    end

    describe "with invalid params" do
      it "assigns the creation as @creation" do
        user.stub(:creations){ mock_creation(:update_attributes => false) }
        put :update, :id => "1", :creation => { :category_ids => [] }
        assigns(:creation).should be(mock_creation)
      end

      it "re-renders the 'edit' template" do
        user.stub(:creations){ mock_creation(:update_attributes => false) }
        put :update, :id => "1", :creation => { :category_ids => [] }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested creation" do
      user.stub(:creations){ mock_creation }
      mock_creation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the creations list" do
      user.stub(:creations){ mock_creation }
      delete :destroy, :id => "1"
      response.should redirect_to(creations_url)
    end
  end

end
