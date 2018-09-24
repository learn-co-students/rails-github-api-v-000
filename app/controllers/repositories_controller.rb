class RepositoriesController < ApplicationController
  def index
    user_resp = Faraday.get "https://api.github.com/user" do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
      end
      @login = JSON.parse(user_resp.body)['login']
       repo_resp = Faraday.get "https://api.github.com/user/repos" do |req|
        req.headers['Authorization'] = "token #{session[:token]}"
      end
      @repos = JSON.parse(repo_resp.body)
  end
end
