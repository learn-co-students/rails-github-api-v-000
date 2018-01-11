class RepositoriesController < ApplicationController

  def index
    respt = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    response_token = JSON.parse(respt.body)
    @username = response_token["login"]

    respr = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(respr.body)

  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {name: params[:name]}.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    redirect_to root_path
  end
end
