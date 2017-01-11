class SessionsController < ApplicationController
  skip_before_action :require_login
  before_action :redirect_if_logged_in, except: 'destroy'

  def new
    params[:session] = { name: '' }
  end

  def create
    user = User.find_by(name: session_params[:name].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user.admin? ? marathons_path : team_path
    else
      flash.now[:danger] = 'Invalid name/password combination'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  def signup
    @user = User.new
  end

  def register
    @user = User.new(user_params)
    @user.access = 0
    if @user.save
      log_in(@user)
      flash[:success] = 'Registration complete'
      redirect_to @user.admin? ? marathons_path : team_path
    else
      render :signup
    end
  end

  private

  def session_params
    params.require(:session)
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def redirect_if_logged_in
    redirect_to current_user if logged_in?
  end
end
