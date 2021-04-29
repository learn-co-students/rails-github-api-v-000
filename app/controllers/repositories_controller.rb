class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @body = JSON.parse(@resp.body)

    @repo = Faraday.get "https://api.github.com/user/repos" do |rep|
      rep.headers['Authorization'] = 'token ' + session[:token]
    end
    @body_2 = JSON.parse(@repo.body)
  
  end

  def create
  end
end
