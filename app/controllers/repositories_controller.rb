class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers["Accept"] = "application/json"
    end
    @username = JSON.parse(@resp.body).first["owner"]["login"]
    @results = JSON.parse(@resp.body)
  end

  def create
    @resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {name: "#{params[:name]}"}.to_json
    end
    redirect_to '/'
  end

end