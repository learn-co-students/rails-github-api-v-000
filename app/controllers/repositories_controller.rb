class RepositoriesController < ApplicationController

  def index
    access_token = session[:token]

    user = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{access_token}"
      req.headers['Accept'] = "application/json"
    end

    @user_info = JSON.parse(user.body)

    repos = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{access_token}"
      req.headers['Accept'] = "application/json"
    end

    @repo_info = JSON.parse(repos.body)
#binding.pry
  end

end
