class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:site_hits] = 0
      if user.role == "admin"
        redirect_to admin_reports_url
      else
        redirect_to store_url
      end
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:site_hits] = nil
    redirect_to store_url, notice: t(:logged_out)
  end
end
