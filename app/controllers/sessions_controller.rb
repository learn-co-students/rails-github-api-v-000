class SessionsController < ApplicationController

	def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
    	req.params['client_id'] = ENV["GITHUB_CLIENT_ID"]
    	req.params['client_secret'] = ENV ["GITHUB_CLIENT_SECRET"]
    	req.params["code"]  = params[:code]
    	req.params['Authorization'] = session[:token]
    end
  end

  	user_response = Faraday.get "https://api.github.com/user"  do |req|
    	req.session[:username] = user_json["login"]
			req.session[:username] = user_json["login"]

    redirect_to '/'
  	end
  end

end



