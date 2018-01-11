class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    # 2. GitHub redirects back to your site
    # POST https://github.com/login/oauth/access_token
    # If the user accepts your request, GitHub redirects
    # back to your site with a temporary code in a code parameter
    resp = Faraday.post 'https://github.com/login/oauth/access_token', {
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET'],
      code: params[:code]
    }, {
      Accept: 'application/json'
    }
    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    # 3. Use the access token to access the API
    # GET https://api.github.com/user?access_token=...
    # You can pass the token in the query params,
    # but a cleaner approach is to include it in the Authorization header
    resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    session[:username] = body["login"]
    redirect_to root_path
  end
end
