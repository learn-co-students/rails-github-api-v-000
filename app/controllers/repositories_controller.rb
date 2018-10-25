class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}"}
    end
    @results = JSON.parse(resp.body)
    user_info = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}"}
    end
    user = JSON.parse(user_info.body)
    @username = user["login"]
 end
end
