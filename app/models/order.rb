class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  scope :by_date, ->(from: Time.now.midnight, to: Time.now) do
    where(created_at: (from .. to))
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
      item.order_id = self.id
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
