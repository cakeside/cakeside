require 'spec_helper'

describe "creations/show.html.erb" do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  def mock_creation(stubs={})
    @mock_creation ||= mock_model(Creation, stubs).as_null_object
  end

  before(:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user, :authenticate! => mock_user)
    @creation = assign(:creation, stub_model(Creation,
      :name => "Name",
      :story => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
