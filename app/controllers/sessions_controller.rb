class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(params[:email], params[:password])
    if @user && @user.activated?
      log_in_user!(@user)
      redirect_to @user
    else
      !@user ? flash.now.alert = "Incorrect Email/Password" :
               flash.now.notice = "Please activate your account -- check your email."
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to root_url
  end
end
