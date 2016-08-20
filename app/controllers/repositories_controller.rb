class RepositoriesController < ApplicationController
  def index
    binding.pry
    resp = Faraday.post("https://api.github.com/oauth/access_token") do |req|
      # need to show current user's repositories based on oauth token's scope
      req.params['client_id']     = nil
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['code']          = '20'
      # req.params['oauth_token']   = session[:token]
      # hoping to grab params from form in index view below
      # req.params['repo']          = params[:name]
      # req.params['v']           = '20160201'
      req.headers                 = {'Accept' => 'application/json'} 
    end
    @repositories
  end

  def create
    resp = Faraday.get("https://api.github.com/users") do |req|
      # need to show current user's repositories based on oauth token's scope

      req.params['oauth_token'] = session[:token]
      # hoping to grab params from form in index view below
      req.params['repo']        = params[:name]
      req.params['v']           = '20160201'
    end
    binding.pry

    @repositories = JSON.parse(resp.body)#["response"]["repos"]
    
    redirect_to root_path
  end
end
