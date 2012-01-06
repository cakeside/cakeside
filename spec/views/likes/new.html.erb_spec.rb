require 'spec_helper'

describe "likes/new.html.erb" do
  before(:each) do
    assign(:like, stub_model(Like,
      :user_id => 1,
      :creation_id => 1
    ).as_new_record)
  end

  it "renders new like form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => likes_path, :method => "post" do
      assert_select "input#like_user_id", :name => "like[user_id]"
      assert_select "input#like_creation_id", :name => "like[creation_id]"
    end
  end
end
