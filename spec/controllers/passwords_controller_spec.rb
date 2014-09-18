require "rails_helper"

describe PasswordsController do
  describe "#new" do
    it "loads a page to reset a password" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
  end
end
