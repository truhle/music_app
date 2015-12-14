class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      log_in_user!(@user)
      redirect_to @user
    else
      render :new
  end

  def destroy
    session[:session_token] = nil
    redirect_to root_url
  end
end
