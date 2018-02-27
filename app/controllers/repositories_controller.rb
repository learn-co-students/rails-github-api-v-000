class RepositoriesController < ApplicationController

  def index
  	#binding.pry

  	resp = Faraday.get('https://api.github.com/user/repos',
  	{}, {Authorization: "token #{session[:token]}"})
  		#req.params['access_token'] = session[:token]
  	binding.pry
  	@repositories = JSON.parse(resp.body)
  end

  def create
  	resp = Faraday.post('https://api.github.com/user/repos',
  	  {
  	  	#access_token: session[:token],
  	  	#scope: 'repo',
  	  	name: "#{params[:name]}",
  	  	}.to_json,
  	  {Authorization: "token #{session[:token]}",
  	  Accept: "application/json"})
  	#binding.pry
  	redirect_to root_path
  end
end
