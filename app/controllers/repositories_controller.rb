class RepositoriesController < ApplicationController
  

  def index
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
    end
    
    @repos=JSON.parse(resp.body)
  end

  def create
  end
end
