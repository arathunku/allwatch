#encoding: utf-8
class Look < ActiveRecord::Base
  attr_accessible :look_query, :name_query
  belongs_to :user
  has_many :auctions, dependent: :destroy

  validates :user_id, presence: true
  validates :look_query, presence: true, 
                         length: { maximum: 255 }
  validates :name_query, presence: true, 
                         length: { maximum: 255, minimum: 3 }
  default_scope order: "looks.updated_at DESC"
  
  def self.prepare(current_user, params)
    ActiveRecord::Base.include_root_in_json = false
    params[:look_for][:search_order] = "1"
    params[:look_for][:search_order_type] = "0"
    current_user.looks.new(name_query: params[:look_for][:search_string],
                           look_query: ActiveSupport::JSON.encode(params[:look_for]))
  end
end
