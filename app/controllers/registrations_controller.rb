class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    resource.admin? ? marathons_path : team_path
  end
end
