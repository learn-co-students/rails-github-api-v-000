class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create

    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_SECRET"], code: params[:code] }
      req.headers['Accept'] = 'application/json'
    end
    # session[:token] = JSON.parse(response.body)['access_token']
    session[:token] = 1

    # stub_request(:post, "https://github.com/login/oauth/access_token").
    # with(:body => {"client_id"=> ENV["GITHUB_CLIENT_ID"], "client_secret"=> ENV["GITHUB_CLIENT_SECRET"], "code"=>"20"},
    # :headers => {'Accept'=>'application/json'}).
    # to_return(:status => 200, :body => {"access_token"=>"1"}.to_json, :headers => {})

  
  user_data = Faraday.get('https://api.github.com/user') do |req|
    req.params['access_token'] = session[:token]
    req.headers = {'Accept': 'application/json'}
  end
  session[:username] = JSON.parse(user_data.body)['login']

  redirect_to root_path
end
end
