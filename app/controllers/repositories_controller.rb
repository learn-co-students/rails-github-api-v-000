class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
    end
    #binding.pry
    @repos = JSON.parse(resp.body)
    binding.pry
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params['name'] = params[:name]
      req.params['oauth_token'] = session[:token]
    end
    redirect_to root_path
  end
end
