class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy, after_add: :increment_line_items_count,
  after_remove: :decrement_line_items_count
  has_many :products, -> { where enabled: true }, through: :line_items

  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def increment_line_items_count(cart)
    self.line_items_count += 1
  end

  def decrement_line_items_count(cart)
    self.line_items_count -= 1
  end

end
