VALID_PERMALINK_REGEX = /\A[^ ][a-zA-Z0-9\-]+\z/
NOT_NULL_REGEX = /[^ ]/
VALID_IMAGE_REGEX = /[.jpg]\z/

class Product < ActiveRecord::Base
  has_many :line_items, dependent: :restrict_with_error
  has_many :carts, through: :line_items
  belongs_to :category, autosave: true
  has_many :images, dependent: :destroy

  # validates :category_id, presence: true
  # validates :title, :description, :image_url, presence: true
  # validates :permalink, format: { with: VALID_PERMALINK_REGEX }
  # validates :permalink, format: { with: NOT_NULL_REGEX }
  # validates_length_of :description, in: 5..10, tokenizer: ->(str) { str.scan(/\w+/) }
  # validates :price, numericality: {greater_than_or_equal_to: 0.01}, if: :is_price_empty?
  # validates :title, :permalink, uniqueness: true
  # validates_length_of :permalink, minimum: 3, tokenizer: ->(str) { str.split('-') }
  # validates :image_url, allow_blank: true, format: {
  #   with: %r{\.(gif|jpg|png)\Z}i,
  #   message: 'must be a URL for GIF, JPG or PNG image.'
  # }
  # validates_each :image_url do |record, attr, value|
  #   record.errors.add(attr, 'must end with .jpg') if
  #   value !~ VALID_IMAGE_REGEX
  # end
  # validates :price, numericality: {greater_than_or_equal_to: :discount_price}


  # before_destroy :ensure_not_referenced_by_any_line_item
  after_initialize :ensure_default_title
  after_save :increment_count_in_cateogory

  scope :enabled, -> { where(enabled: true) }

  def ensure_default_title
    self.title = 'abc' unless self.title
    self.discount_price = self.price unless self.discount_price
  end

  def self.latest
    Product.order(:updated_at).last
  end

  def is_price_empty?
    price == ""
  end

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  protected
    def increment_count_in_cateogory
      if (category)
        Category.increment_counter(:count, category_id)
        if (category.parent_category.present?)
          Category.increment_counter(:count, category.parent_category_id)
        end
      end
    end

end
