class RepositoriesController < ApplicationController
  

  def index
    @user_name = session[:username]

    user_info = Faraday.get 'https://api.github.com/user/repos', {}, {'Authorization': "token #{session[:token]}"}
    @user_repos = JSON.parse(user_info.body)
  end

  def create
    resp = Faraday.post 'https://api.github.com/user/repos', {name: params[:name]}.to_json, {'Authorization': "token #{session[:token]}"}

    redirect_to root_path
  end
end
