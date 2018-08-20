class RepositoriesController < ApplicationController

  skip_before_action :authenticate_user

  def index
    resp = Faraday.get('https://api.github.com/purnima-nyc/repos') do |req|
      req.params['oauth_token'] = session[:token]
      #req.params['v'] = '3'
    end
    @repos = JSON.parse(resp.body)["items"]
    #@username = JSON.parse(resp.body)["items"]["owner"]["login"]
  end



  def create
    resp = Faraday.post("https://api.github.com/purnima-nyc/repos") do |req|
      req.params['oauth_token'] = session[:token]
      #req.params['v'] = '3'
      req.params['name'] = params[:name]
    end
    redirect_to repositories_path
  end
end

