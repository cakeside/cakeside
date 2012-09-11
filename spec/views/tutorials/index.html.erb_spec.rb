require 'spec_helper'

describe "tutorials/index" do
  before(:each) do
    assign(:tutorials, [
      stub_model(Tutorial,
        :heading => "Heading",
        :description => "MyText",
        :url => "Url"
      ),
      stub_model(Tutorial,
        :heading => "Heading",
        :description => "MyText",
        :url => "Url"
      )
    ])
  end

  it "renders a list of tutorials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "h3", :text => "Heading".to_s, :count => 2
    assert_select "p", :text => "MyText".to_s, :count => 2
  end
end
