class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user?access_token=") do |req|
      req.params['oauth_token'] = session[:token]
      # don't forget that pesky v param for versioning
      req.params['v'] = '20160201'
    end
    @repo = JSON.parse(resp.body)
  end

  def create
  end
end
