class SessionsController < ApplicationController

  def destroy #3
    logout_user!
    redirect_to new_session_url
  end

  def new #4
    render :new
  end

  def create #5
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

    if user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    else
      login_user!(user)
      redirect_to root_url
    end
  end

end
