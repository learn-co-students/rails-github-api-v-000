class RepositoriesController < ApplicationController
  
  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    binding.pry
    @user_data = JSON.parse(user.body)
  end

end
