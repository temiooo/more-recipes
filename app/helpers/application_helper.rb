module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def require_user
    if !logged_in?
      flash[:error] = "Please log in to do that."
      redirect_to root_path
    end
  end

  def is_authenticated?
    if logged_in?
      redirect_to categories_path
    end
  end
end
