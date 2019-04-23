class RepositoriesController < ApplicationController

  def index
    user_response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    user_body = JSON.parse(user_response.body)
    @login = user_body["login"]

    response = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(response.body)


  end

end
