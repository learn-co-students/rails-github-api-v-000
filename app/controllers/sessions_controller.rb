class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
     resp = Faraday.post("https://github.com/login/oauth/access_token", { 'client_id' => ENV["GITHUB_CLIENT_ID"], 'client_secret' => ENV["GITHUB_CLIENT_SECRET"], 'code' => params[:code]}, {'Accept' => 'application/json'})
     session[:token] = JSON.parse(resp.body)["access_token"]

     user_resp = Faraday.get("https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'})
     user_responses = JSON.parse(user_resp.body)
     session[:username] = user_responses["login"]
     session[:repo_url] = user_responses["repos_url"]

     redirect_to '/'
  end
end

#helpful: https://stackoverflow.com/questions/23555508/faraday-post-request-to-getpocket-api
