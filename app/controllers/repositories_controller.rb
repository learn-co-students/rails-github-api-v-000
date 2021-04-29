class RepositoriesController < ApplicationController

  def index
    # resp = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @username = JSON.parse(user.body)['login']
    repos = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repositories = JSON.parse(repos.body)
  end

end
