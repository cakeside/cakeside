require 'spec_helper'

describe "tutorials/index" do
  before(:each) do
    assign(:tutorials, [
      stub_model(Tutorial,
        :heading => "Heading",
        :description => "MyText",
        :url => "Url",
        :created_at => DateTime.new(2012, 9, 13)
      ),
      stub_model(Tutorial,
        :heading => "Heading",
        :description => "MyText",
        :url => "Url",
        :created_at => DateTime.new(2012, 9, 13)
      )
    ])
  end

  it "renders a list of tutorials" do
    render
    assert_select "h3", :text => "Heading September. 13, 2012", :count => 2
    assert_select "p", :text => "MyText".to_s, :count => 2
  end
end
