require 'pry'
class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(response.body)
    #binding.pry
  end

  def create
    request = Faraday.post "https://api.github.com/user/repos", {:name=>"a-new-repo"}.to_json , {'Authorization' => "token #{session[:token]}",'Accept' => 'application/json'}
    redirect_to '/'
  end
end
