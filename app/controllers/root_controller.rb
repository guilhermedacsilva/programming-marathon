class RootController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to marathons_path
      else
        redirect_to teams_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end
