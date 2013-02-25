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
  before {@look = user.looks.new(name_query: "garmin",
                                 look_query: "{items to find form}")}
  subject { @look }

  it { should respond_to(:user_id) }
  it { should respond_to(:name_query) }
  it { should respond_to(:look_query) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @look.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Look.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  describe "look associations" do
    before { user.save }
    let!(:older_micropost) do 
      FactoryGirl.create(:look, user: user, updated_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:look, user: user, updated_at: 1.hour.ago)
    end

    it "should destroy associated microposts" do
      looks = user.looks.dup
      user.destroy
      looks.should_not be_empty
      looks.each do |look|
        Look.find_by_id(look.id).should be_nil
      end
    end

  end

end
