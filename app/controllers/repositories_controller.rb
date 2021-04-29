class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    @user = body['login']

    repos =  Faraday.get("https://api.github.com/user/repos") do |req|
      req.body = { 'sort': 'created' }
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repo_data = JSON.parse(repos.body)
  end

  def create
    response = Faraday.post 'https://api.github.com/user/repos' do |req|
      req.body = { 'name': params[:name] }.to_json
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Scope'] = 'public_repo'
      req.headers['Accept'] = 'application/json'
    end
    redirect_to '/'
  end


end
