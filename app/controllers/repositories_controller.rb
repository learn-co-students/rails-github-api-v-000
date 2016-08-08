class RepositoriesController < ApplicationController
  def index
    @resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @body = JSON.parse(@resp.body)

  end

  def create

    post = Faraday.post("https://api.github.com/user/repos"), {
      name: params[:name]}.to_JSON,
      {'Accept' => 'application/json', 'Authorization' => "token #{session[:token]}"}
 
  
    redirect_to root

  end
end
