class RepositoriesController < ApplicationController

  def index
   response = Faraday.get("http://github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", "Accept" => "application/json"})
    @repos_array = JSON.parse(response.body)
#  .with(body: URI.encode_www_form(request_params))
  #  user = Faraday.get("http://api.github.com/user") do |req|
  #    req.headers['Authorization'] = "token" + session[:token]
  #    req.headers['Accept'] = "application/json"

    repos = Faraday.get("http://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token" + session[:token]
      req.headers['Accept'] = "application/json"
    end

    body = JSON.parse(user.body)
    @user_name = body["login"]
    @repos_list = JSON.parse(repos.body)
  end
end
