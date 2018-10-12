class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      token = session[:token]
      req.body = {'oauth_token': token}
    end
    end

    @user = JSON.parse(user_resp.body)

    repos_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      token = session[:token]
      req.body = {'oauth_token': token}
    end

    @repos = JSON.parse(repos_resp.body)
  end

end
