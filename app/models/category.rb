class Category < ActiveRecord::Base
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_category_id"
  belongs_to :parent_category, class_name: "Category"
  has_many :products

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :parent_category_id, unless: "name.nil?"
  validate :single_level_hierarchy

  before_destroy :ensure_no_associated_products, :destroy_sub_categories

  def single_level_hierarchy
    if (parent_category_id != nil)
      p Category.find(parent_category_id)
      if (Category.find(parent_category_id).parent_category_id != nil)
        errors.add(:base, "Can not have multiple level nested sub categories")
      end
    end
  end

  protected

    def destroy_sub_categories
      begin
        sub_categories.destroy_all
      rescue Exception
        false
      end
    end

    def ensure_no_associated_products
      false if products.present?
    end

end
