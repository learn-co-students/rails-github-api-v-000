class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
    @username = JSON.parse(resp.body)['login']
  end

end
