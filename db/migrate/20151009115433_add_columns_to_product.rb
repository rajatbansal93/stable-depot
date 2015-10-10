class AddColumnsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :enabled, :boolean, default: false
    add_column :products, :line_item_count, :decimal, default: 0
    add_column :products, :discount_price, :decimal, precision: 8, scale: 2
    add_column :products, :permalink, :string
  end
end
