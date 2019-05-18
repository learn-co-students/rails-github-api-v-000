class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
    end

    @results = JSON.parse(resp.body)

  end

end
