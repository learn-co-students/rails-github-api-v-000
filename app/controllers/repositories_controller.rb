class RepositoriesController < ApplicationController
  def index
    resp3 = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

  @repos = JSON.parse(resp3.body)
end


  def create
    resp4 = Faraday.post "https://api.github.com/user/repos" do |req|
      req['name'] = params[:name]
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    redirect_to root_path
  end
end
