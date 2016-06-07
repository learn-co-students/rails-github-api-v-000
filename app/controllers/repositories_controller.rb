class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] =  "token #{session[:token]}"
    end
    # binding.pry
    @user = JSON.parse(resp.body)

    resp2 = Faraday.get("https://api.github.com/users/#{@user['login']}/repos")
    @repos = Kaminari.paginate_array(JSON.parse(resp2.body)).page(params[:page])
  end

  def create

    # resp2 = Faraday.get("https://api.github.com/user") do |req|
    #   req.headers['Authorization'] =  "token #{session[:token]}"
    # end
    # # binding.pry
    # @user = JSON.parse(resp2.body)

    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = "{'name' => #{params['name']}}"
      req.headers['Authorization'] =  "token #{session[:token]}"
    end
    redirect_to '/'
  end
end
