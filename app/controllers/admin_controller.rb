class AdminController < ApplicationController
  def index
    if User.find(session[:user_id]).role == "admin"
      @total_orders = Order.count
    else
      redirect_to store_url, notice: "you are not authorize for this action"
    end
  end
end
