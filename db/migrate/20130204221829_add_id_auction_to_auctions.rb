class AddIdAuctionToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :auction_id, :integer
    add_index :auctions, [:auction_id]
  end
end
