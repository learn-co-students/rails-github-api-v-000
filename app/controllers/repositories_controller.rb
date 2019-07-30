class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT'], 'client_secret': ENV['GITHUB_SECRET'], 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    @user = body["login"]

    render 'index'
  end

end
