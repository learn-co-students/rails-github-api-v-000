module SessionsHelper
  def greet_user
    content_tag :h1, "#{session[:username]}" if session[:username]
  end
end
