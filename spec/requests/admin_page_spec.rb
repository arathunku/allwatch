# encoding: utf-8
require 'spec_helper'
describe "Admin" do
  before do
    @user_admin = FactoryGirl.create(:user, email: "arathunku@gmail.com")
    @user = FactoryGirl.create(:user)
  end
  describe "successful login" do
    before(:each) do
      sign_in(@user_admin)
    end
    it "should see" do
      get "admin"
      response.should be_success
    end
  end
  describe "unauthorized access to admin page" do
    before(:each) do
      sign_in(@user)
    end
    it "should return 404" do
      lambda {
        get "admin"
      }.should raise_error(ActionController::RoutingError)
    end
  end

  describe "delete" do
    before(:each) do
      sign_in(@user_admin)
    end
    describe "admin should not be allowed delete himself" do
      it do
        delete "admin/#{@user_admin.id}"
        flash[:warning].should_not be_nil
        flash[:success].should be_nil
      end
    end
    describe "admin should be allow delete others" do
      it do
        delete "admin/#{@user.id}"
        flash[:success].should_not be_nil
        flash[:warning].should be_nil
      end
    end
  end
end