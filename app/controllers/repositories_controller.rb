class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
    end
    @results = JSON.parse(resp.body)
  end

  def create
    data = {'name': params[:name]}
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.body = data.to_json
      #req.body['name'] = params[:name]
    end
    redirect_to root_path
  end
end