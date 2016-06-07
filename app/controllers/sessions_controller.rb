class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  
  # params form
    # {"code"=>"4478076e9be334ecc16c", "controller"=>"sessions", "action"=>"create"} 
  def create
    #raise params.inspect
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    # raise response.inspect
    # response form
      # access_token=e72e16c7e42f292c6912e7710c838347ae178b4a&scope=user%2Cgist&token_type=bearer
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]
    #raise session[:token].inspect
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    #raise user_response.inspect
    user_json = JSON.parse(user_response.body)
    #raise user_json.inspect
    session[:username] = user_json["login"]
    
    redirect_to '/'
  end

end