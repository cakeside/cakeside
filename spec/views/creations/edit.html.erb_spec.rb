require 'spec_helper'

describe "creations/edit.html.erb" do
  before(:each) do
    @creation = assign(:creation, stub_model(Creation,
      :name => "MyString",
      :story => "MyText"
    ))
  end

  it "renders the edit creation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => creations_path(@creation), :method => "post" do
      assert_select "input#creation_name", :name => "creation[name]"
      assert_select "textarea#creation_story", :name => "creation[story]"
    end
  end
end
