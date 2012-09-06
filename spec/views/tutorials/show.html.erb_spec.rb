require 'spec_helper'

describe "tutorials/show" do
  before(:each) do
    @tutorial = assign(:tutorial, stub_model(Tutorial,
      :heading => "Heading",
      :description => "MyText",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Heading/)
    rendered.should match(/MyText/)
    rendered.should match(/Url/)
  end
end
