class Image < ActiveRecord::Base
  belongs_to :product
  before_save :ensure_max_3_images

  protected
    def ensure_max_3_images
      false if Image.where(product_id: product_id).count >= 3
    end
end
