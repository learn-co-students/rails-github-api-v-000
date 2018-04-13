class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
 
  # POST https://github.com/login/oauth/access_token
  #   ?client_id=
  #   &client_secret=
  #   &code=
  
  # The code below works but, won't pass the spec.
  # def create
  #   resp = Faraday.post("https://github.com/login/oauth/access_token", { client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET'], code: params[:code]}, { 'Accept' => 'application/json' })
  
  #   body = JSON.parse(resp.body)
  #   session[:token] = body["access_token"]
  #   redirect_to root_path
  # end
  
  # This code passes the spec.
  # stub_request(:post, "https://github.com/login/oauth/access_token").
  #     with(:body => {"client_id"=> ENV["GITHUB_CLIENT_ID"], "client_secret"=> ENV["GITHUB_CLIENT_SECRET"], "code"=>"20"},
  #     :headers => {'Accept'=>'application/json'}).
  #     to_return(:status => 200, :body => {"access_token"=>"1"}.to_json, :headers => {})
      
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token", {"client_id"=> ENV["GITHUB_CLIENT_ID"], "client_secret"=> ENV["GITHUB_CLIENT_SECRET"], "code"=> params[:code]}, {'Accept'=>'application/json'})
    
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end

