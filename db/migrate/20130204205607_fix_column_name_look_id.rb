class FixColumnNameLookId < ActiveRecord::Migration
  def up
    rename_column :auctions, :id_look, :look_id
  end

  def down
  end
end
