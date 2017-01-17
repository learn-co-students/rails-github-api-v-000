class RepositoriesController < ApplicationController
  def index
    token = session[:token]

    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{token}"
    end
    user = JSON.parse(resp.body)
    session[:username] = user['login']
  end

  def create
  end
end
