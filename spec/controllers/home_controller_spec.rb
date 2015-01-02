require "rails_helper"

describe HomeController do
  it "should render the about us page" do
    get "about_us"
    expect(response).to be_success
  end

  it "should render the why cakeside page" do
    get "why_cakeside"
    expect(response).to be_success
  end
end
