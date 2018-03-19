class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      #binding.pry
      req.headers = {}
      req.headers["Authorization"] = 'token ' + session[:token]
      #binding.pry
    end
    @repos = JSON.parse(resp.body)
    resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers = {}
      req.headers["Authorization"] = 'token ' + session[:token]
    end
    #binding.pry
    body = JSON.parse(resp.body)
    @username = body["login"]
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.body = {}
      req.body["name"] = params[:name]
      req.body = JSON.generate(req.body)
      req.headers["Authorization"] = 'token ' + session[:token]
      #binding.pry
    end
    #binding.pry
    redirect_to root_path
  end
end
