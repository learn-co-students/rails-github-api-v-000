class RepositoriesController < ApplicationController
  def index

    user_info = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {'Authorization' => "token #{session[:token]}"}
    end

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      # binding.pry
      req.headers = {'Authorization' => "token #{session[:token]}"}
    end

    @repos = JSON.parse(resp.body)
    @user = JSON.parse(user_info.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {'Authorization' => "token #{session[:token]}"}
      req.body = {
        'name' => params['name']
      }.to_json
    end
    
    redirect_to root_path
  end
end
