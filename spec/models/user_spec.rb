# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do
  describe "FactoryGirl" do
    it "should be valid" do
      FactoryGirl.create(:user).should be_valid
      FactoryGirl.build(:user, email: "example2@example.com").should be_valid
    end
  end

  it "should ACCEPT variations of email adresses" do
    adresses = %w[abcd@examp.ecom AbXd@example.com.pl ak+2@ek.pl ak.2@ek.pl]
    adresses.each do |adress|
      FactoryGirl.build(:user, email: adress).should be_valid
    end
  end

  it "should REJECT variations of email adresses" do
    adresses = %w[abcdexamp.ecom AbXd@example.com,pl ak.2@ek]
    adresses.each do |adress|
      FactoryGirl.build(:user, email: adress).should_not be_valid
    end
  end

  it "should REJECT duplicate email adress" do
    FactoryGirl.create(:user).should be_valid
    FactoryGirl.build(:user).should_not be_valid
  end

  describe "passwords" do
    before do
      @user = User.new(email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
    end
    subject { @user }

    it { should be_valid }

    describe "when password is not present" do
      before { @user.password = @user.password_confirmation = " " }
      it { should_not be_valid }
    end

    describe "when password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end

    describe "when password confirmation is nil" do
      before { @user.password_confirmation = nil }
      it { should_not be_valid }
    end

    describe "when password is too short" do
      before { @user.password_confirmation = @user.password = "a"*5 }
      it { should_not be_valid }
    end

  end
end
