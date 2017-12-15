class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
      req.params['oauth_token'] = session[:token]
    end
    @body = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
      req.body = "{ \"name\": \"#{params[:name]}\" }"
    end
    redirect_to root_path
  end
end
