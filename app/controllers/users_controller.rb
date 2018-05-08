class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to categories_path, notice: "Thank you for signing up!"
    else
      flash[:error] = @user.errors.full_messages[0]
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :phone_number, :password)
  end
end
