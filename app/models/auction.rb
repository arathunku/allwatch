# == Schema Information
#
# Table name: auctions
#
#  id         :integer          not null, primary key
#  look_id    :integer
#  name       :string(255)
#  price_atm  :decimal(10, 3)
#  price_buy  :decimal(10, 3)
#  end_time   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  auction_id :integer
#  type       :integer          default(0)
#

class Auction < ActiveRecord::Base
  attr_accessible :look_id, :name, 
                  :price_atm, :price_buy, 
                  :end_time, :auction_id,
                  :auction_type
  belongs_to :look

  validate :look_id,      presence: true
  validate :name,         presence: true, length: { maximum: 255 }
  validate :end_time,     presence: true, length: { maximum: 255 }
  validate :auction_type, presence: true
  default_scope order: "price_buy asc, price_atm asc"

  def link
    "http://www.allegro.pl/i#{self.auction_id}.html"
  end


  def show?
    if Time.now > self.end_time || self.auction_type !=  Look.find_by_id(self.look_id).offer_type
      "hide-auction"
    else 
      "show-auction"
    end
  end
end
