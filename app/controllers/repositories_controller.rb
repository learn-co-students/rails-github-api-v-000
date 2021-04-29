class RepositoriesController < ApplicationController
  
  def index

    resp1 = Faraday.get "https://api.github.com/user" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user_data = JSON.parse(resp1.body)

    resp2 = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(resp2.body)

  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {'name': params['name']}.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    redirect_to root_path
  end

end
