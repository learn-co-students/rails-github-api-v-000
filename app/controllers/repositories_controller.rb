class RepositoriesController < ApplicationController

  def index
    response = Faraday.get "https://api.github.com/user" do |req|
        req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user = JSON.parse(response.body)

    response = Faraday.get "https://api.github.com/user/repos" do |req|
        req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    
    @repos = JSON.parse(response.body)
  end

end
