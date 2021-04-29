class RepositoriesController < ApplicationController

  def index
    token = session[:token]
    resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{token}"
    end
    @username = JSON.parse(resp.body)["login"]
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{token}"
    end
    @repositories = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.params['oauth_token'] = session[:token]
      req.params['name'] = params[:name]
      req.params['X-OAuth-Scopes'] = 'repo'
    end
    redirect_to '/'
  end

end
