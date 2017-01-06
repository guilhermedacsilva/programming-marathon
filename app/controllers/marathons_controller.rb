class MarathonsController < ApplicationController
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
end
