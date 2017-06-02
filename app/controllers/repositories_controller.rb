class RepositoriesController < ApplicationController
  def index
    puts session
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

   @repos = JSON.parse(resp.body)
   @username = @repos[1]["owner"]["login"]
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos",{name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
