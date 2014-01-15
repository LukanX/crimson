class PeriodsController < ApplicationController

  def create
    Period.create(period_params)
  end

  def new
    Period.new
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
