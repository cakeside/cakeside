require 'spec_helper'

describe "likes/index.html.erb" do
  before(:each) do
    assign(:likes, [
      stub_model(Like,
        :user_id => 1,
        :creation_id => 1
      ),
      stub_model(Like,
        :user_id => 1,
        :creation_id => 1
      )
    ])
  end

  it "renders a list of likes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
