module ApplicationHelper

  def display_username
    if logged_in?
      response = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
      json = JSON.parse(response.body)
      username = json["login"]

      content_tag(:h2, username)
    end
  end

  def logged_in?
    !!session[:token]
  end
end
