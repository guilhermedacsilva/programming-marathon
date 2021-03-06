class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include SessionsHelper

  def after_sign_in_path_for(resource)
    resource.admin? ? marathons_path : team_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
