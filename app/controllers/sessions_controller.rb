class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
    params[:session] = { name: '' }
  end

  def create
    user = User.find_by(name: session_params[:name].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid name/password combination'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session)
  end
end
