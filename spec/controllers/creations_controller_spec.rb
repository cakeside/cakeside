require 'spec_helper'

describe CreationsController do
  let(:user){ create(:user) }
  let(:creation){ create(:creation, :user => user) }

  before(:each) do
    photo = File.new(File.join(Rails.root, 'spec/fixtures/images/example.png'))
    creation.add_photo(photo)
  end

  describe :index do
    let(:restricted_creation){ create(:creation, :user => user, :is_restricted => true) }

    before { get :index }

    it "should display all creations" do
      assigns(:creations).should include(creation)
    end

    it "should not include restricted creations" do
      assigns(:creations).should_not include(restricted_creation)
    end
  end

  context "when logged in" do
    before { http_login(user) }

    describe :show do
      it "assigns the requested creation" do
        get :show, :id => creation.id
        assigns(:creation).should == creation
      end
    end

    describe :new do
      it "assigns a new creation" do
        new_creation = double
        Creation.stub(:new).and_return(new_creation)
        get :new
        assigns(:creation).should be(new_creation)
      end
    end

    describe :edit do
      it "assigns the requested creation as @creation" do
        get :edit, :id => creation.id
        assigns(:creation).should eq(creation)
      end
    end

    describe :post do
      describe "with valid params" do
        let(:category) { create(:category) }

        before :each do
          post :create, :creation => { :name => 'stone', :story => 'morning glory', :is_restricted => true, :watermark => "watery"}, :creation_tags => 'cake', :category_id => category.id
        end

        it "assigns a newly created creation" do
          assigns(:creation).should_not be_nil
          assigns(:creation).name.should == 'stone'
          assigns(:creation).story.should == 'morning glory'
          assigns(:creation).is_restricted.should be_true
          assigns(:creation).watermark.should == 'watery'
        end

        it "redirects to the created creation" do
          response.should redirect_to(new_creation_photo_path(assigns(:creation)))
        end
      end

      describe "with invalid params" do
        before { post :create, :creation => {:name => ''} }

        it "re-renders the 'new' template" do
          response.should render_template("new")
        end

        it "should include the errors" do
          assigns(:creation).errors.count.should > 0
        end
      end
    end

    describe :patch do
      describe "with valid params" do
        before { patch :update, :id => creation.id, :creation => {:name => 'params'} }

        it "assigns the requested creation as @creation" do
          assigns(:creation).should == creation
        end

        it "redirects to the creation" do
          response.should redirect_to new_creation_photo_path(creation.reload)
        end
      end

      describe "with invalid params" do
        before { put :update, :id => creation.id, :creation => {:name=> nil } }

        it "assigns the creation as @creation" do
          assigns(:creation).should == creation
        end

        it "re-renders the 'edit' template" do
          response.should render_template("edit")
        end

        it "should display an error" do
          flash[:error].should_not be_nil
        end
      end
    end

    describe :destroy do
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

    describe :mine do
      let!(:my_creation) { create(:creation) }
      let!(:other_creation) { create(:creation) }

      before :each do
        user.creations << my_creation
        get :mine
      end

      it "should return all of my creations" do
        assigns(:creations).should include(my_creation)
      end

      it "should not return any other creations" do
        assigns(:creations).should_not include(other_creation)
      end
    end
  end

end
