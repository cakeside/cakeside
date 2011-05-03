require 'spec_helper'

describe "creations/new.html.erb" do
  before(:each) do
    assign(:creation, stub_model(Creation,
      :name => "MyString",
      :story => "MyText"
    ).as_new_record)
  end

  it "renders new creation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => creations_path, :method => "post" do
      assert_select "input#creation_name", :name => "creation[name]"
      assert_select "textarea#creation_story", :name => "creation[story]"
    end
  end
end
