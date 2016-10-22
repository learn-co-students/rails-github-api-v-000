class RepositoriesController < ApplicationController
  def index
    if logged_in?
      get_username 
      get_repos
    end
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]
      req.params['name'] = params[:name]
      # req.params['score'] = 'public_repo'
    end
    binding.pry
  end

  private

  def get_username
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]
    end
    body = JSON.parse(resp.body)
    @username = body['login']
  end

  def get_repos
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]
    end
    @repos = JSON.parse(resp.body)
    # .page(params[:page])
  end
end
