require 'pry'
class RepositoriesController < ApplicationController
  def index
    username = Faraday.get("https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'})
    repositories = Faraday.get("https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'})
    @username = JSON.parse(username.body)["login"]
    @repositories = JSON.parse(repositories.body)

  end


  def create
    Faraday.post("https://api.github.com/user/repos", {'name' => "#{params["name"]}"}.to_json, {'Authorization' => "token #{session[:token]}"})
    redirect_to '/'
  end
end
