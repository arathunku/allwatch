class Auction < ActiveRecord::Base
  attr_accessible :look_id, :name, :price_atm, :price_buy, :end_time, :auction_id
  belongs_to :look

  validate :look_id, presence: true
  validate :name, presence: true, length: { maximum: 255 }
  validate :end_time, presence: true, length: { maximum: 255 }
  default_scope order: "price_atm asc, price_buy asc"
  def link
    "http://www.allegro.pl/i#{self.auction_id}.html"
  end


  def show?
    Time.now > self.end_time ? "hide-auction" : "show-auction"
  end

end
