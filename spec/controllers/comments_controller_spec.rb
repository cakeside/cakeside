describe CommentsController do
  describe "POST create" do
    describe "when signed in" do
      let(:user) { FactoryGirl.create(:user) }
      let(:creation) { FactoryGirl.create(:creation) }
      before :each do
        http_login(user)
      end
      describe 'when commenting on a creation' do
        before(:each) do
          post :create, {:creation_id => creation.id, :comment => {:body => 'blah'}}
        end
        it "should display a message indicated that the comment was saved" do
          flash[:notice].should_not be_nil
        end
        it "should redirect to the creation#show page" do
          response.should redirect_to(creation)
        end
      end
    end
  end
end
