class RepositoriesController < ApplicationController
  
  def index

    # get username
    user_response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    user_info = JSON.parse(user_response.body)
    session[:username] = user_info["login"]

    # get repos
    
    repo_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @repos_list = JSON.parse(repo_response.body)

  end

end
