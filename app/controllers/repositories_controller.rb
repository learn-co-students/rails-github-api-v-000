class RepositoriesController < ApplicationController

  def index
    response = Faraday.get("https://api.github.com/user") do |request|
      request.body = { 'oauth_token': session[:token] }
      request.headers['Authorization'] = "token #{session[:token]}"
    end
    @login = JSON.parse(response.body)["login"]

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.body = { 'oauth_token': session[:token] }
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repositories = JSON.parse(resp.body)
  end

  # def create
  # end
end
