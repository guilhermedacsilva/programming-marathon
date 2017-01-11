class MarathonsController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_marathon, except: [:index, :new, :create]
  layout 'marathon', only: [:show]

  def index
    @marathons = admin? ? Marathon.order(:name) : Marathon.all_started
    # @marathons = @marathons.any? ? @marathons : nil
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
    @marathon.destroy
    flash[:notice] = 'Marathon moved to trash'
    redirect_to marathons_path
  end

  def status
    @marathon.toggle!(:started)
    redirect_to marathon_path(@marathon)
  end

  private

  def set_marathon
    @marathon = Marathon.find(params[:id])
  end

  def params_marathon
    params.require(:marathon).permit(:name)
  end
end
