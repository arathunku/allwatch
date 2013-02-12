class ChangeColumnType < ActiveRecord::Migration
  def up
    change_column :auctions, :auction_id, :integer, limit: 8
  end

  def down
    change_column :auctions, :auction_id, :integer
  end
end
