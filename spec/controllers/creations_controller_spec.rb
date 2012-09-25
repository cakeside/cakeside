require 'spec_helper'

describe CreationsController do
  let(:user){ FactoryGirl.create(:user) }
  let(:creation){ FactoryGirl.create(:creation, :user => user) }

  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
  end

  describe "GET index" do
    it "assigns all creations as @creations" do
      get :index
      assigns(:creations).should eq([creation])
    end
  end

  describe "GET show" do
    it "assigns the requested creation as @creation" do
      get :show, :id => creation.id
      assigns(:creation).should eq(creation)
    end
  end

  describe "GET new" do
    it "assigns a new creation as @creation" do
      new_creation = fake
      Creation.stub(:new) { new_creation }
      get :new
      assigns(:creation).should be(new_creation)
    end
  end

  describe "GET edit" do
    it "assigns the requested creation as @creation" do
      get :edit, :id => creation.id
      assigns(:creation).should eq(creation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created creation as @creation" do
        post :create, :creation => {:id => creation.id, :name => 'new name'}
        assigns(:creation).name.should == 'new name'
      end

      it "redirects to the created creation" do
        creations = fake
        creation = fake
        user.stub(:creations){ creations }
        creations.stub(:create).and_return(creation)
        creation.stub(:id).and_return(1006)
        creation.stub(:save).and_return(true)
        post :create, :creation => {}
        response.should redirect_to('/creations/crop/1006')
      end
    end

    describe "with invalid params" do
      def mock_creation(stubs={})
        @mock_creation ||= mock_model(Creation, stubs).as_null_object
      end
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
      before :each do
        put :update, :id => creation.id, :creation => {:name => 'params'}
      end
      it "assigns the requested creation as @creation" do
        assigns(:creation).should eq(creation)
      end

      it "redirects to the creation" do
        response.should redirect_to("/creations/#{creation.id}-params")
      end
    end

    describe "with invalid params" do
      before :each do
        put :update, :id => creation.id, :creation => {:name=> nil, :category_ids => [] }
      end
      it "assigns the creation as @creation" do
        assigns(:creation).should eq(creation)
      end

      it "re-renders the 'edit' template" do
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      delete :destroy, :id => creation.id
    end
    it "destroys the requested creation" do
      user.creations.count.should == 0
    end
    it "redirects to the creations list" do
      response.should redirect_to(creations_url)
    end
  end
end
