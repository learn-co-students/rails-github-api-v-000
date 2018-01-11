class RepositoriesController < ApplicationController
  def index
  	response = Faraday.get "https://api.github.com/user/repos" do |req|
      req["Authorization"] = "token #{session[:token]}"
      req["Accept"] = "application/json"
    end
    @repos = JSON.parse(response.body)
  end

  def create
  	response = Faraday.post "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
      req.body = {name: params[:name]}.to_json
    end
    redirect_to '/'
  end
end
