class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to log_in_path
    else
      render 'new'
    end
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:uname,:email,:password, :password_confirmation)
  end

end
