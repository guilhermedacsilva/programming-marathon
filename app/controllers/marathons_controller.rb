class MarathonsController < ApplicationController
  before_action :require_admin
  before_action :set_marathon, except: [:index, :new, :create]
  layout 'marathon', only: [:show]

  def index
    @marathons = Marathon.order(:name)
  end

  def new
    @marathon = Marathon.new
  end

  def create
    @marathon = Marathon.new(marathon_params)
    if @marathon.save
      flash[:notice] = 'Marathon created successfully'
      redirect_to @marathon
    else
      render :new
    end
  end

  def update
    if @marathon.update(marathon_params)
      flash[:notice] = 'Marathon updated'
    else
      flash[:error] = 'Invalid marathon update'
    end
    redirect_to @marathon
  end

  def show
    @exercises = 0
    @teams = 0
  end

  def destroy
    @marathon.destroy
    flash[:notice] = 'Marathon moved to trash'
    redirect_to marathons_path
  end

  private

  def set_marathon
    @marathon = Marathon.find(params[:id])
  end

  def marathon_params
    params.require(:marathon).permit(:name, :started, :can_register)
  end
end
