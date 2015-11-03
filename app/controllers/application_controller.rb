class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :increment_site_hits

  protected

  def increment_site_hits
    session[:site_hits] += 1 if session[:site_hits]
  end

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
