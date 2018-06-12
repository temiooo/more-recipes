class SessionsController < ApplicationController
  before_action :is_authenticated?, only: [:new, :create]

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, you've logged in."
    else
      flash[:error] = "Incorrect username or password"
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to login_path
  end
end
