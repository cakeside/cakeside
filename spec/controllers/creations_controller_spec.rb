require 'spec_helper'

describe CreationsController do
  include Devise::TestHelpers

  let(:user){ Factory.create(:user) }
  let(:creation){ Factory.create(:creation) }

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  def mock_creation(stubs={})
    @mock_creation ||= mock_model(Creation, stubs).as_null_object
  end

  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user, :authenticate! => mock_user)
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
      # Creation.stub(:find).with("37") { mock_creation }
      mock_user.stub(:creations){ mock_creation }
      get :edit, :id => "37"
      assigns(:creation).should be(mock_creation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created creation as @creation" do
        # Creation.stub(:new).with({'these' => 'params'}) { mock_creation(:save => true) }
        mock_user.stub(:creations){ mock_creation(:save => true) }
        post :create, :creation => {'these' => 'params'}
        assigns(:creation).should be(mock_creation)
      end

      it "redirects to the created creation" do
        # Creation.stub(:new) { mock_creation(:save => true) }
        mock_user.stub(:creations){ mock_creation(:save => true) }
        post :create, :creation => {}
        response.should redirect_to(creation_url(mock_creation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved creation as @creation" do
        # Creation.stub(:new).with({'these' => 'params'}) { mock_creation(:save => false) }
        mock_user.stub(:creations){ mock_creation(:save => false) }
        post :create, :creation => {'these' => 'params'}
        assigns(:creation).should be(mock_creation)
      end

      it "re-renders the 'new' template" do
        # Creation.stub(:new) { mock_creation(:save => false) }
        mock_user.stub(:creations){ mock_creation(:save => false) }
        post :create, :creation => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested creation" do
        # Creation.stub(:find).with("37") { mock_creation }
        mock_user.stub(:creations){ mock_creation }
        mock_creation.should_receive(:update_attributes).with({'these' => 'params', 'category_ids' => []})
        put :update, :id => "37", :creation => {'these' => 'params'}
      end

      it "assigns the requested creation as @creation" do
        # Creation.stub(:find) { mock_creation(:update_attributes => true) }
        creation = mock_creation(:update_attributes => true, :category_ids => [])
        mock_user.stub(:creations){ creation }
        put :update, :id => "1", :creation => { :category_ids => [] }
        assigns(:creation).should be(creation)
      end

      it "redirects to the creation" do
        # Creation.stub(:find) { mock_creation(:update_attributes => true) }
        mock_user.stub(:creations){ mock_creation(:update_attributes => true) }
        put :update, :id => "1", :creation => { :category_ids => [] }
        response.should redirect_to(creation_url(mock_creation))
      end
    end

    describe "with invalid params" do
      it "assigns the creation as @creation" do
        mock_user.stub(:creations){ mock_creation(:update_attributes => false) }
        # Creation.stub(:find) { mock_creation(:update_attributes => false) }
        put :update, :id => "1", :creation => { :category_ids => [] }
        assigns(:creation).should be(mock_creation)
      end

      it "re-renders the 'edit' template" do
        mock_user.stub(:creations){ mock_creation(:update_attributes => false) }
        # Creation.stub(:find) { mock_creation(:update_attributes => false) }
        put :update, :id => "1", :creation => { :category_ids => [] }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested creation" do
#      Creation.stub(:find).with("37") { mock_creation }
      mock_user.stub(:creations){ mock_creation }
      mock_creation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the creations list" do
      Creation.stub(:find) { mock_creation }
      delete :destroy, :id => "1"
      response.should redirect_to(creations_url)
    end
  end

end
