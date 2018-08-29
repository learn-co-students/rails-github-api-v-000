class RepositoriesController < ApplicationController

  def index
    #binding.pry
    authenticate_user
    #auth_result = JSON.parse(RestClient.get('https://api.github.com/user',
    #                                    {:params => {:access_token => access_token}}))

    #resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    #  req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
    #  req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
    #  req.params['grant_type'] = 'authorization_code'
    #  req.params['redirect_uri'] = "http://localhost:3000/auth"
    #  req.params['code'] = params[:code]
    #end
    #binding.pry
    #auth = Faraday.get("https://api.github.com/user", {:params => {:access_token => session[:token]}})
    #auth_result = JSON.parse(Faraday.get('https://api.github.com/user',{:params => {:access_token => session[:token]}}))
    #auth_result = Faraday.get('https://api.github.com/user',{:params => {:access_token => session[:token]}})
    auth_result = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    auth_body = JSON.parse(auth_result.body)
    @username = auth_body["login"]

    repo_result = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    binding.pry
    @repo_body = JSON.parse(repo_result.body)

    binding.pry

  end

end
