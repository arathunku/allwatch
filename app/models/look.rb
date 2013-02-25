#encoding: utf-8
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

class Look < ActiveRecord::Base
  attr_accessible :user_id, :look_query, :name_query, :offer_type
  belongs_to :user
  has_many :auctions, dependent: :destroy

  validates :user_id, presence: true
  validates :look_query, presence: true, 
                         length: { maximum: 255 }
  validates :name_query, presence: true, 
                         length: { maximum: 255, minimum: 3 }
  validates :offer_type, inclusion: { in: 0..3 }
  default_scope order: "looks.updated_at DESC"
  
  def self.prepare(current_user, params)
    ActiveRecord::Base.include_root_in_json = false
    params[:look_for][:search_order] = "1"
    params[:look_for][:search_order_type] = "0"
    current_user.looks.new(name_query: params[:look_for][:search_string],
                           look_query: ActiveSupport::JSON.encode(params[:look_for]),
                           offer_type: params[:offer_type].to_i)
  end
end
