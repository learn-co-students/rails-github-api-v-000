class RepositoriesController < ApplicationController
  def index
    resp1 = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = 'token ' +session[:token]
      req.headers['Accept'] = 'application/json'
    end
    body1 = JSON.parse(resp1.body)
    @user = body1["login"]

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' +session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp2.body)
  end

  def create
    requestbody = "{\"name\":\"" + params[:name]+"\"}"
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = 'token ' +session[:token]
      req.headers['Content-Type'] = 'application/json'
      req.body = requestbody
    end
    redirect_to root_path
  end
end
