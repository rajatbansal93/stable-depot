class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    respond_to do |format|

      format.html
      format.json {

        if (Rating.where("product_id = ? AND user_id = ?", params[:product_id], session[:user_id]).exists?)
          user_rating = Rating.where("product_id = ? AND user_id = ?", params[:product_id], session[:user_id]).first
          user_rating.rating = params[:rating]
          user_rating.save
        else
          @rating = Rating.new(rating: params[:rating], product_id: params[:product_id], user_id: session[:user_id])
          @rating.save
        end
        average_rating = Rating.where(product_id: params[:product_id]).average("rating").round(2)
        render :json => {
          average_rating: average_rating,
          product_id: params[:product_id]
        }
      }
    end

  end

end
