class Auction < ActiveRecord::Base
  attr_accessible :look_id, :name, :price_atm, :price_buy, :end_time
  belongs_to :look

  validate :look_id, presence: true
  validate :name, presence: true, length: { maximum: 255 }
  validate :end_time, presence: true, length: { maximum: 255 }

end
