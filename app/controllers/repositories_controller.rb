class RepositoriesController < ApplicationController
  def index
    @user = session[:username]

    resp = Faraday.get "https://api.github.com/users/#{@user}/repos"
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos?name=#{params[:name]}" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    redirect_to '/'

  end
end
