class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  #validates_uniqueness_of :product_id, scope: :cart_id

  def total_price
    if product
      product.price * quantity
    else
      0
    end
  end
end
