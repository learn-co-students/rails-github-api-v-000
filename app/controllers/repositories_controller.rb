
class RepositoriesController < ApplicationController
	before_action :authenticate_user
  
	def index 
		response = Faraday.get "https://api.github.com/user/repos" do |req|
			req.params['Authorization'] = session[:token]
			@repos = JSON.parse(response.body)
		end
	end

	def create 
		response = Faraday.post "https://api.github.com/user/repos" do |req|
			req.body['name'] = '{'params':name'}'
			req.body['Authorization'] = '{'session':token}'
			
			redirect_to '/'
		end
	end

end