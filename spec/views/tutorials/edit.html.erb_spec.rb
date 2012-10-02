require 'spec_helper'

describe "tutorials/edit" do
  before(:each) do
    @tutorial = assign(:tutorial, FactoryGirl.build(:tutorial))
  end

  it "renders the edit tutorial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tutorials_path(@tutorial), :method => "post" do
      assert_select "input#tutorial_heading", :name => "tutorial[heading]"
      assert_select "textarea#tutorial_description", :name => "tutorial[description]"
      assert_select "input#tutorial_url", :name => "tutorial[url]"
    end
  end
end
