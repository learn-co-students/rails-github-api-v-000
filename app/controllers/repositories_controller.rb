class RepositoriesController < ApplicationController

  def index
    response = Faraday.get("https://api.github.com/users/#{session[:user]}/repos")
    @repos = JSON.parse(response.body)
  end

  def create
    resp = Faraday.post 'https://api.github.com/user/repos', {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
#
# def index
#   response = Faraday.get("https://api.github.com/users/#{session[:user]["login"]}/repos")
#   @repos = JSON.parse(response.body)
# end
#
# def create
#   Faraday.post("https://api.github.com/users/#{session[:user]}/repos") do |repo|
#     repo.params['name'] = params[:name]
#     repo.params['authorization'] = params[:token]
#   end
#   redirect_to root_path
# end
