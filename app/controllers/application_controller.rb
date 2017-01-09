class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :require_login

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  def require_admin
    redirect_to marathons_path unless current_user.admin?
  end
end
