class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      redirect_to @user
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end



private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
