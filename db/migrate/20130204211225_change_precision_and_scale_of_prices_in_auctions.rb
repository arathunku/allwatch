class ChangePrecisionAndScaleOfPricesInAuctions < ActiveRecord::Migration
  def up
     change_column :auctions, :price_atm, :decimal, scale: 3, precision: 10
     change_column :auctions, :price_buy, :decimal, scale: 3, precision: 10
  end

  def down
  end
end
