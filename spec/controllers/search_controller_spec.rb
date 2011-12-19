require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index', {:q => 'blah'}
      response.should be_success
    end
  end

end
