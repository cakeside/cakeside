require 'spec_helper'

describe "likes/show.html.erb" do
  before(:each) do
    @like = assign(:like, stub_model(Like,
      :user_id => 1,
      :creation_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
