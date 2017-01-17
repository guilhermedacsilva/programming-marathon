class TeamsController < ApplicationController
  before_action :require_team

  def index
    @marathons = Marathon.all_can_register
  end

  def register_for_marathon
    marathon = Marathon.find_by(id: params[:marathon])
    if marathon
      if marathon.can_register
        current_user.marathon = marathon
        current_user.save
        flash[:notice] = 'Registration done.'
      else
        flash[:error] = 'Marathon closed.'
      end
    else
      flash[:error] = 'Marathon not found.'
    end
    redirect_to team_path
  end
end
