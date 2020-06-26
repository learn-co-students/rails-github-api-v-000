class RepositoriesController < ApplicationController

  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers = { Authorization: "token #{session[:token]}" }
    end
    resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers = { Authorization: "token #{session[:token]}" }
    end
    @repos = JSON.parse(resp.body)
    @user = JSON.parse(user.body)['login']
  end

end
