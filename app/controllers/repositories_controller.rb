class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/self/repos") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['name'] = params[:name]
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params["oauth_token"] = session[:token]
      req.params['name'] = params[:name]
    end
    redirect_to '/'
  end



end
