class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  # def create #my version
  #   #temporary github code
  #   session_code = params[:code]
  #   result = Faraday.post('https://github.com/login/oauth/access_token') do |req|
  #     req.body = {
  #       "client_id": ENV['GITHUB_CLIENT_ID'],
  #       "client_secret": ENV['GITHUB_CLIENT_SECRET'],
  #       "code": session_code
  #     }, req.headers['Accept'] = 'application/json'
  #   end
  #   binding.pry
  #   access_token = JSON.parse(result)['access_token']
  #   binding.pry
  #
  #   # resp = Faraday.get()
  # end

  # def create #action gets hit from routes.rb's get '/auth' => 'sessions#create'
  #   # use temp code to post to get the real legit token.
  #   session_code = params[:code]
  #   # ... and POST it back to GitHub
  #   result = RestClient.post('https://github.com/login/oauth/access_token',
  #                           {:client_id => ENV['GITHUB_CLIENT_ID'],
  #                            :client_secret => ENV['GITHUB_CLIENT_SECRET'],
  #                            :code => session_code},
  #                            :accept => :json)
  #   session[:token] = JSON.parse(result)['access_token']
  #   # use the personal access token I got to access my very private info.
  #   kevin_info = JSON.parse(RestClient.get('https://api.github.com/user',
  #                                       {:params => {:access_token => session[:token]}}))
  #   session[:username] = kevin_info["login"]
  #   redirect_to root_path
  # end

  def create #soln...incomprehensible with Faraday...test revolves around it passing this way...
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    redirect_to root_path
  end
end
