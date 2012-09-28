describe CommentsController do
  describe "when signed in" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      http_login(user)
    end
    describe "POST create" do
      let(:creation) { FactoryGirl.create(:creation) }
      before(:each) do
        http_login(user)
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
