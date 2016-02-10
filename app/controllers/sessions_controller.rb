class SessionsController < ApplicationController

  def new
    if session[:user_id]
      user = User.find(session[:user_id])
      redirect_to user_path(user)
    end
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end

  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      flash[:success] = "You have successfully logged out"
      redirect_to login_path
    else
      redirect_to login_path
    end
  end

end