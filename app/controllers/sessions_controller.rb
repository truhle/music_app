class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(params[:email], params[:password])
    if @user
      log_in_user!(@user)
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to root_url
  end
end
