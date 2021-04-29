class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(@resp.body)

    @user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    body = JSON.parse(@user.body)
    @name = body['login']
    render 'index'
  end

end
