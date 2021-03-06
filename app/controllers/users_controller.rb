class UsersController < ApplicationController

  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, period_attributes:[:start_date, :end_date, :user_id])
  end

  def show
    @user = current_user
    @periods = @user.periods.all
  end

  def index
    @users = User.all
  end
end
