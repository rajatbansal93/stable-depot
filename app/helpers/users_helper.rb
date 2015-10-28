module UsersHelper

  def average_rating(product)
    Rating.where(product_id: product.id).average("rating")
  end

end
