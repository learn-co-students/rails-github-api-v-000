class RepositoriesController < ApplicationController
  def index
    # raise params.inspect
    # resp1 = Faraday.get("https://api.github.com/user") do |req|
    #   req.params['access_token'] = session[:token]
    # end

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      # req.body = {
      #   "access_token": session[:token],
      #   "sort": "created",
      #   "direction": "desc"
      # }
      req.params['access_token'] = session[:token]
      req.params['sort'] = "created"
      req.params['direction'] = "desc"
    end

    # @username = JSON.parse(resp1.body)["login"]
    @repos = JSON.parse(resp2.body)

  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {
        "access_token": "#{session[:token]}",
        "name": "#{params[:name]}",
        "description": "This is your first test repository",
        "homepage": "https://github.com/ivanpilot",
        "private": false,
        "repo": "read",
        "public_repo": "read"
      }
    end

    redirect_to root_path
  end


end
