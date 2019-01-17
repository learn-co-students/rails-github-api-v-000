class RepositoriesController < ApplicationController

  def create
  end

  def index
    # https://www.mobomo.com/2012/03/faraday-one-http-client-to-rule-them-all/
    # https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/
    # Auth and Accept headers needed
    # HTTP headers are meta data about the user's request
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      # https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept?utm_source=mozilla&utm_medium=devtools-netmonitor&utm_campaign=default
      req.headers['Accept'] = "application/json"
    end
    @repos = JSON.parse(resp.body)
  end

end
