class ChangeLineItemCountFieldOfProduct < ActiveRecord::Migration
  def up
    change_column :products, :line_item_count, :int, null: false
  end

  def down
    change_column :products, :line_item_count, :decimal
  end
end
