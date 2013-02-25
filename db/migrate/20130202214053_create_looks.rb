class CreateLooks < ActiveRecord::Migration
  def change
    create_table :looks do |t|
      t.integer :user_id
      t.string :name_query
      t.string :look_query

      t.timestamps
    end
    add_index :looks, [:user_id, :name_query]
  end
end
