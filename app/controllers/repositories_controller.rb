class RepositoriesController < ApplicationController

  def index
    # @resp = Faraday.get "https://api.github.com/user/repos" do |req|
    #   req.params['access_token'] = "#{session[:token]}"
    # end
    # @data = JSON.parse(@resp.body)
    user = Faraday.get "https://api.github.com/user" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user_data = JSON.parse(user.body)

    repos = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token " + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repo_data = JSON.parse(repos.body)
  end

  def create
    @resp = Faraday.post( "https://api.github.com/user/repos", {name:  params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'})
    #   # req.body = {name: params[:name]}
    #   # req.headers['Authorization'] = "token #{session[:token]}" req.headers['Accept'] = 'application/json'
    #   req.params['name'] = params[:name]
    #   req.params['access_token'] = "#{session[:token]}"
    #   req.headers['Accept'] = 'application/json'
    # end
    @results = JSON.parse(@resp.body)
    redirect_to root_path
  end
end
