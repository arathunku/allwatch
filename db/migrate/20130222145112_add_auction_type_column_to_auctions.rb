class AddAuctionTypeColumnToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :auction_type, :integer, default: 0
  end
end
