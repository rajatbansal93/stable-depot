class Admin::ReportsController < ApplicationController
  def index
    if User.find(session[:user_id]).role == "admin"
      @orders = Order.by_date(from: params[:from]||(Date.today - 5).midnight, to: params[:to]||Time.now)
    else
      redirect_to store_url, notice: "you are not authorize for this action"
    end
  end
end
