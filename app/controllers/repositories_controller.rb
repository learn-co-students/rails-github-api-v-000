class RepositoriesController < ApplicationController

  def index
    user_resp = Faraday.get "https://api.github.com/user" do |req|
      # req.params['oauth_token'] = session[:token]
      # req.params['Authorization'] = 'token 1'
      req.params['Authorization'] = "token #{session[:token]}"
    end
    # resp = Faraday.get "https://api.github.com/user/repos" do |req|

    # end

    @login = JSON.parse(user_resp.body)
    @username = @login["login"]
    binding.pry

    render 'index'
  end

end
