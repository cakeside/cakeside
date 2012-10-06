require 'spec_helper'

describe "tutorials/index" do
  before(:each) do
    items = []
    (1..2).each do |item|
      items << FactoryGirl.build(:tutorial, 
                        :heading => "Heading", 
                        :description => "MyText", 
                        :created_at => DateTime.new(2012, 9, 13)
                       )
    end
    assign(:tutorials, Kaminari.paginate_array(items).page(1))
    render
  end

  it "should display the text for each tutorial" do
    assert_select "p", :text => "MyText".to_s, :count => 2
  end

  it "should display the heading for each tutorial" do
    assert_select "h3", :text => "Heading September. 13, 2012", :count => 2
  end
end
