class RepositoriesController < ApplicationController
  def index
  	resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params[:access_token] = session[:token]
      req.headers['Content-Type'] = "application/json"
  	end
  	@repos = JSON.parse(resp.body)

  	 resp = Faraday.get("https://api.github.com/user") do |req|
      req.params[:access_token] = session[:token]
      req.headers['Content-Type'] = "application/json"
    end
    @user = JSON.parse(resp.body)["login"]  
  end

  def create
  	resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params[:access_token] = session[:token]
      req.body = "{ 'name': '#{params[:name]}' }"
      req.headers['Content-Type'] = "application/json"
    end
    redirect_to root_path
  end
end
