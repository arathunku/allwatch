class Look < ActiveRecord::Base
  attr_accessible :look_query, :name_query
  belongs_to :user
  CORRECT_NAME = /^(?:[^\W_]|\s)*$/u


  validates :user_id, presence: true
  validates :look_query, presence: true, 
                         length: { maximum: 255 }
  validates :name_query, presence: true, 
                         length: { maximum: 255, minimum: 3 },
                         format: { with: CORRECT_NAME }
  default_scope order: "looks.updated_at DESC"
end
