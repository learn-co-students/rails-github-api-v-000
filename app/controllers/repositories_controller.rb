class RepositoriesController < ApplicationController
  def index
  	user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
  		# req.params[:access_token] = session[:token]
  	end

  	@username = JSON.parse(user.body)['login']

  	@repositories = Faraday.get("https://api.github.com/users/#{@username}/repos") do |req|
  		req.params[:access_token] = session[:token]
  	end

  	@repositories = JSON.parse(@repositories.body)
  	# @repositories = Kaminari.paginate_array(@repositories).page(params[:page]).per(10)
  end

  def create
  	# body = {
  	#   "name": "#{params[:name]}",
  	#   "description": "created from other app with OAuth",
  	#   "private": "false"
  	# }
    
   #  username = Faraday.get("https://api.github.com/user") do |req|
   #    req.params[:access_token] = session[:token]  
   #  end  
   #  username = JSON.parse(username.body)['login']
    post_repo=Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	# post_repo = Faraday.post("https://api.github.com/user/repos") do |req|
   #    req.headers['Authorization'] = "token #{session[:token]}"
   #    req.params['access_token'] = session[:token]
   #    req.params['scope'] = 'public_repo'
  	# 	req.params['name'] = params[:name].to_json
  	# end
    binding.pry
  	redirect_to '/'
  end
end
