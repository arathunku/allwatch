class RemoveColumnTypeFromAuctions < ActiveRecord::Migration
  def up
    remove_column :auctions, :type
  end

  def down
  end
end
