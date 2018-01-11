class RepositoriesController < ApplicationController
  def index
    #moved to session controller for tests
    # #get username from api
    # response = Faraday.get("https://api.github.com/user") do |req|
    #   req.headers["Authorization"] = "token #{session[:token]}"
    #   req.headers['Accept'] = 'application/json'
    # end
    # body = JSON.parse(response.body)
    # @username = body["login"]


    #raise "stop"
    #get repos from API
    #resp = Faraday.get("https://api.github.com/users/#{@username}/repos") do |req|
      #req.params[""] = 
    #end
    
    

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    #raise "stop".inspect
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      req.body = {name: params[:name]}.to_json
      #req.body = {name: params[:name], scope: "public_repo"}.to_json
    end
    #raise "stop".inspect
    redirect_to '/'

  end
end
