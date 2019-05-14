class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get "https://api.github.com/user" do |req|
    # req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': params[:code] }
    req.headers['Authorization'] = "token #{session[:token]}"
    
    end
  end

  def create
  end
end
