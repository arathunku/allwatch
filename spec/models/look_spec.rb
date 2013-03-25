# == Schema Information
#
# Table name: looks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name_query :string(255)
#  look_query :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  offer_type :integer          default(0)
#

require 'spec_helper'

describe Look do
  let(:user) { FactoryGirl.create(:user) }
  before {@look = FactoryGirl.create(:look, user: user)}
  subject { @look }

  it { should respond_to(:user_id) }
  it { should respond_to(:name_query) }
  it { should respond_to(:look_query) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @look.user_id = nil }
    it { should_not be_valid }
  end
  describe "when name_query is not present" do
    before { @look.name_query = nil }
    it { should_not be_valid }
  end
  describe "when offer type is not within range" do
    before { @look.offer_type = 5}
    it {should_not be_valid}
  end
  describe "when offer type is within range" do
    before { @look.offer_type = 2}
    it {should be_valid}
  end
  describe "look associations" do
    before { user.save }

    it "should destroy associated looks" do
      looks = user.looks.dup
      user.destroy
      looks.should_not be_empty
      looks.each do |look|
        Look.find_by_id(look.id).should be_nil
      end
    end
  end

  describe "saving new record" do
    before do
      @params = {"look_for"=>{"search_string"=>"ABCDEF"}, "offer_type"=>"0"}
      user.save
      @user = user
    end
    
    describe "with proper values" do
      let!(:look_query) {Look.prepare(@params) }
      it "should create new record properly" do
        #debugger
        Look.create!(name_query: @params["look_for"]["search_string"],
                           look_query: look_query,
                           offer_type: @params["offer_type"].to_i,
                           user_id: @user.id)
      end
    end

    describe "prepare method working properly" do
      it { @params.keys.should include("offer_type") }
      it { @params.keys.should include("look_for") }
      it { Look.prepare(@params).should be_a(String) }
    end
    
  end
end
