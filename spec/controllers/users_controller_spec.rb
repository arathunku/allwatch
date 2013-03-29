#encoding: utf-8 
require 'spec_helper'
describe UsersController do
  describe "GET new" do
    it "should render" do
      get :new
      response.should be_success
    end
  end
  describe "POST create" do
    before(:each){
      @user_attr = FactoryGirl.attributes_for(:user) 
    }
    #it "should create new user" do
      #expect { 
      #  post :create, user: @user_attr 
      #}.to change(User, :count).by(1)
    pending "CHECK"
    #end
  end
  describe "GET edit" do
    pending "CHECK"
  end
  describe "POST update" do
    pending "CHECK"
  end
end
