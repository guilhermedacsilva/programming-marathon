module SessionsHelper
  def admin?
    current_user.admin?
  end

  private

  def require_admin
    redirect_to team_path unless admin?
  end

  def require_team
    redirect_to marathons_path if admin?
  end
end
