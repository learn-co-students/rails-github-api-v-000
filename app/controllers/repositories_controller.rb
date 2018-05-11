class RepositoriesController < ApplicationController
  def index
    @username = session[:username]
    resp = Faraday.get("https://api.github.com/users/#{@username}/repos") do |req|
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    redirect_to '/'
  end
end