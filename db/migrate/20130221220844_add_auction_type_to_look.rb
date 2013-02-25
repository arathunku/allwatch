class AddAuctionTypeToLook < ActiveRecord::Migration
  def change
    add_column :looks, :offer_type, :integer, default: 0
    add_index :looks, [:offer_type]

    add_column :auctions, :type, :integer, default: 0
    add_index :auctions, [:type]
  end
end
