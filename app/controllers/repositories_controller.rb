class RepositoriesController < ApplicationController

  def index
    response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(response.body)

    user_response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
  end

end
