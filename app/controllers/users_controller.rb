class UsersController < ApplicationController

  before_action :must_be_logged_in, only: :show
  before_action :admin_only, only: [:index, :make_admin]

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    if !@user.activated?
      @user.toggle!(:activated)
      log_in_user!(@user)
      flash.notice = "Account activated!"
      redirect_to @user
    else
      flash.alert = "Account already activated"
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    @user.set_activation_token
    if @user.save
      ActivationMailer.account_activation(@user).deliver_now
      flash.notice = "Please check your email to activate your account"
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @users = User.all.sort
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    redirect_to users_url
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
