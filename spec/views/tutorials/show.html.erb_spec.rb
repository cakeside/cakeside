require 'spec_helper'

describe "tutorials/show" do
  before(:each) do
    @tutorial = assign(:tutorial, stub_model(Tutorial,
      :heading => "Heading",
      :description => "MyText",
      :url => "Url",
      :image_url => "http://placehold.it/300x200",
      :created_at => DateTime.new(2012, 9, 20)
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Heading/)
    rendered.should match(/MyText/)
    rendered.should match(/Url/)
  end
end
