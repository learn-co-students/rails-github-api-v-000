class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      # need to show current user's repositories based on oauth token's scope
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept']        = 'application/json'
    end

    resp  = JSON.parse(resp.body)
    @user = resp['login']
    @url  = resp['repos_url']

    repos = Faraday.get(@url) do |req|
      req.headers['authorization'] = "token #{session[:token]}"
      req.headers['accept']        = 'application/json'
    end

    @repositories = JSON.parse(repos.body)

  end

  def create
    resp = Faraday.get("https://api.github.com/users") do |req|
      # need to show current user's repositories based on oauth token's scope

      req.params['oauth_token'] = session[:token]
      # hoping to grab params from form in index view below
      req.params['repo']        = params[:name]
    end
    binding.pry

    @repositories = JSON.parse(resp.body)#["response"]["repos"]
    
    redirect_to root_path
  end
end
