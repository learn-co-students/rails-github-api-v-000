require 'json'
class RepositoriesController < ApplicationController
  def index
    @user = current_user
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]["access_token"]
      req.params['token_type'] = session[:token]["token_type"]
      req.params['affiliation'] = 'owner'
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]["access_token"]
      req.params['token_type'] = session[:token]["token_type"]
      req.body = { 
        'name': params['name']
      }.to_json
    end
    redirect_to root_path
  end
end
