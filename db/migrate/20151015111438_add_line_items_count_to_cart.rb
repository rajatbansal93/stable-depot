class AddLineItemsCountToCart < ActiveRecord::Migration
  def change
    add_column :carts, :line_items_count, :int, default: 0
  end
end
