class MarathonsController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_marathon, only: [:show, :edit, :update, :destroy]

  def index
    @marathons = admin? ? Marathon.order(:name) : Marathon.all_started
  end

  def new
    @marathon = Marathon.new
  end

  def create
    @marathon = Marathon.new(params_marathon)
    if @marathon.save
      flash[:notice] = 'Marathon created successfully'
      redirect_to @marathon
    else
      render :new
    end
  end

  def show
    @exercises = 0
    @teams = 0
  end

  def destroy
    Marathon.destroy(params[:id])
    flash[:notice] = 'Marathon moved to trash'
    redirect_to marathons_path
  end

  private

  def set_marathon
    @marathon = Marathon.find(params[:id])
  end

  def params_marathon
    params.require(:marathon).permit(:name)
  end
end