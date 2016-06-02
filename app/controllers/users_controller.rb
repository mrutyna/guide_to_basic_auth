class UsersController < ApplicationController

  def new #4
    @user = User.new
    render :new
  end

  def create #5
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private #3

  def user_params #3
    params.require(:user).permit(:password, :username)
  end
end
