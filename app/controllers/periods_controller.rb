class PeriodsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @period = current_user.periods.build(period_params)
    if @period.save
      #flash [:success] = "Period Saved"
      redirect_to root_url
    else
      render new
    end
  end

  def new
    @period = current_user.periods.new
  end

  def show
    @period = current_user.periods.find(params[:id])
  end

  def index
    @periods = current_user.periods.all
  end

  def edit
    @period = current_user.periods.find(params[:id]);
  end

  def update
    @period = current_user.periods.find(params[:id])
    if @period.update_attributes(period_params)
      redirect_to root_url
    else
      render edit
    end
  end

  def destroy
    @period.destroy
    redirect_to root_url
  end


  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def period_params
    params.require(:period).permit(:start_date, :end_date, :user_id)
  end

end
