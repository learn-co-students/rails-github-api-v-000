class RepositoriesController < ApplicationController

  def index
    response = Faraday.get "https://api.github.com/users/#{session[:username]}/repos" do |req|
      req["Authorization"] = "token #{session[:token]}"
      req["Accept"] = "application/json"
    end
    @repos = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos" do |req|
      req["Authorization"] = "token #{session[:token]}"
      # req["Accept"] = "application/json"
      req.params['name'] = params[:name].to_json
      req.params['private'] = false
    end
    raise response.inspect
    redirect_to '/'
  end

end
