class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    repos_resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @username = JSON.parse(user_resp.body)["login"]
    @repos = JSON.parse(repos_resp.body)
    render 'index'
  end

end
