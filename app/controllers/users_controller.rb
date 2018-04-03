class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You are registered."
      redirect_to recipes_path
    else
      puts  @user.errors.full_messages
      puts "++++++++++++++++++=="
      flash[:error] = "Something went wrong, please try again."
      # binding.pry
      redirect_to register_path
      # render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :phonenumber, :password)
  end
end
