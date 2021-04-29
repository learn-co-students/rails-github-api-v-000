class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'],
        'client_secret': ENV['GITHUB_CLIENT_SECRET']
        }
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
     body = JSON.parse(resp.body)
    @login = body["login"]
     response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'],
        'client_secret': ENV['GITHUB_CLIENT_SECRET']
        }
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
     @repo_body = JSON.parse(response.body)
  end

end
