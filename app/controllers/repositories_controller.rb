class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def reset_session
      session[:token] = nil
  end
  # def index
      # oauth_token = session[:token]['access_token']
      # resp = Faraday.get("https://api.github.com/user/repos") do |req|
      # req.headers['Accept'] = 'application/json'
      # req.headers['Authorization'] = "token #{oauth_token}"
      #  req.headers['Authorization'] = "token #{session[:token]}"
      #  end
      #  @repos = JSON.parse(resp.body)
      # user_resp = Faraday.get("https://api.github.com/user") do |req|
      #     req.headers['Authorization'] = "token #{session[:token]}"
      # end

      # mos_def = JSON.parse(user_resp.body)
      # @user = mos_def['login']

             # reset_session
  # end
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos_array = JSON.parse(response.body)
  end

  def create
      # @repo_name = params[:name]
      # resp = Faraday.post("https://api.github.com/user/repos") do |req|
      #     req.headers['Authorization'] = "token #{session[:token]}"
      #     req.body = { "{\"name\":\"#{@repo_name}\"}"=> true }
      # end
      response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
