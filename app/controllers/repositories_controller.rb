class RepositoriesController < ApplicationController
  def index
    #response = Faraday.get("https://api.github.com/user/repos") do |req|
    #  req.params["access_token"] = session[:token]
    #end
    response = Faraday.get("https://api.github.com/user/repos", {}, 'Authorization' => "token #{session[:token]}", 'Accept' => "application/json")
    @repos = JSON.parse(response.body)

  end

  def create

      #conn = Faraday.new(:url => 'http://api.github.com')
#
      ## post payload as JSON instead of "www-form-urlencoded" encoding:
      #conn.post do |req|
      #  req.url '/user/repos'
      #  req.headers['Authorization'] = session[:token]
      #  req.body = {name: params[:name]}.to_json
      #end

    response = Faraday.post("https://api.github.com/user/repos", {name: params[:name]}.to_json, 'Authorization' => "token #{session[:token]}", 'Accept' => "application/json")

    redirect_to root_path
  end
end
