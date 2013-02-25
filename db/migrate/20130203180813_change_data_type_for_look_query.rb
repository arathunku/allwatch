class ChangeDataTypeForLookQuery < ActiveRecord::Migration
  def up
    change_table :looks do |t|
      t.change :look_query, :text
    end
  end

  def down
    change_table :looks do |t|
      t.change :look_query, :string
    end
  end
end
