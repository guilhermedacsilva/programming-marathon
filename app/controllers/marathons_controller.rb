class MarathonsController < ApplicationController
  before_action :set_marathon, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @marathons = Marathon.all_openned
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def set_marathon
    @marathon = Marathon.find(params[:id])
  end
end
