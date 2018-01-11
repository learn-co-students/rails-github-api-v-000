class RepositoriesController < ApplicationController
  #skip_before_action :authenticate_user
  
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['per_page'] = "50"
    end

    @body = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {"name": "test_api_create"}.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
      #binding.pry
    end
    #binding.pry
    
    redirect_to root_path
  end
end
