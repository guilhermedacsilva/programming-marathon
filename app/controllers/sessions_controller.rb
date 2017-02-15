class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    resource.admin? ? marathons_path : team_path
  end


end
