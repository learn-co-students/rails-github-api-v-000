class RepositoriesController < ApplicationController

  def index

      resp = Faraday.get "https://api.github.com/user" do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = "token #{session[:token]}"

      end

      body = JSON.parse(resp.body)
      @login = body["login"]

      resp = Faraday.new(:url => 'http://www.example.com') 
      # resp = Faraday.get "https://api.github.com/user/repos" do |req|
      #
      #   req.headers['Accept'] = 'application/json'
      #   req.headers['Authorization'] = "token #{session[:token]}"
      #
      # end

      body = JSON.parse(resp.body)
#binding.pry
      @items =  body.map{|y| y["name"]}
      repos_url = body["repos_url"]


    render 'index'

  end

  def create

    resp = Faraday.post "https://api.github.com/user/repos?name=#{params[:name]}"  do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    redirect_to '/'

  end
end
