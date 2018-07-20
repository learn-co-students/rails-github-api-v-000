class RepositoriesController < ApplicationController

  def index
    @user_resp = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repo_resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    parsed_repos = JSON.parse(@repo_resp.body)
    parsed_user = JSON.parse(@user_resp.body)
    if @repo_resp.success? && @user_resp.success?
      @repos = parsed_repos
      @user = parsed_user
    else
      @error = "Something went wrong."
    end
  end

  def create
    Faraday.post 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = JSON.generate({"name"=> params[:name]})
    end
    redirect_to root_path
  end

end
