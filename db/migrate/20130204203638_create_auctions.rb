class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer :id_look
      t.string :name
      t.decimal :price_atm
      t.decimal :price_buy
      t.datetime :end_time
      t.timestamps
    end
    add_index :auctions, [:id_look, :price_atm, :price_buy, :name, :end_time], uniq: true, name: "auctions_index"
  end
end
