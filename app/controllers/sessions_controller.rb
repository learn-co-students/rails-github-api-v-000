class SessionsController < ApplicationController

  skip_before_action :authenticate_user

  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token', 
    {
      :client_id => ENV['CLIENT_ID'],
      :client_secret => ENV['CLIENT_SECRET'],
      :code => params['code']
    },
    :accept => :json)
    
    binding.pry
    # @user = JSON.parse(resp)
    # sessions[:token] = @user[:access_token]
    
    redirect_to root_path
  end

end