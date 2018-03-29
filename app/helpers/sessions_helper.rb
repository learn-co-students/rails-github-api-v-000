module SessionsHelper

  def display_user_name
    session[:user].capitalize
  end
end
