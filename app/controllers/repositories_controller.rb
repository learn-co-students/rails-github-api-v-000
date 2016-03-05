class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get "https://api.github.com/user/repos", {
      access_token: session[:token]
    }
    @body = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name], {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}}
    # body = JSON.parse(resp.body)
    binding.pry
    redirect_to '/'
  end
end
