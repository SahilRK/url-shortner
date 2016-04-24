class SessionsController < ApplicationController

  def new
  end

  def create
    session_user = User.authenticate_user(params[:email], params[:password])
    if session_user
      session[:user_id] = session_user.id
      redirect_to short_urls_path, notice: "logged in"
    else
      flash.now.alert = "Invalid User"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil;
    redirect_to root_url, notice: "User succesfully logged out"
  end
end
