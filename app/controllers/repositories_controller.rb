class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    body_json = JSON.parse(resp.body)
    @username = body_json['login']

    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(resp.body)
  end

end