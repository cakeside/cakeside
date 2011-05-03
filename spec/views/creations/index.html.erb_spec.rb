require 'spec_helper'

describe "creations/index.html.erb" do
  before(:each) do
    assign(:creations, [
      stub_model(Creation,
        :name => "Name",
        :story => "MyText"
      ),
      stub_model(Creation,
        :name => "Name",
        :story => "MyText"
      )
    ])
  end

  it "renders a list of creations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
