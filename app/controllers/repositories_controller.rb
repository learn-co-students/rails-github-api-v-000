class RepositoriesController < ApplicationController
  
  def index

    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']

    user_response = Faraday.get 'https://api.github.com/user' do |req|
      req.body = {'client_id': client_id, 'client_secret': client_secret }
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}"}
    end

    user = JSON.parse(user_response.body)
    @username = user['login']

    repos_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.body = {'client_id': client_id, 'client_secret': client_secret }
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}"}
    end

    @repos = JSON.parse(repos_response.body)    
  end

  def create
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']

    response = Faraday.post 'https://api.github.com/user/repos' do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'name': params['name'] }
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}"}
    end

    body = JSON.parse(response.body)

    redirect_to '/'
  end

end
