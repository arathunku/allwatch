class ChangeUserIdType < ActiveRecord::Migration
  def up
    change_column :auctions, :auction_id, :bigint
  end

  def down
    change_column :auctions, :auction_id, :integer
  end
end
