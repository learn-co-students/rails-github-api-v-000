class RepositoriesController < ApplicationController
  def index
  end

  def create
    # resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
    #   req.params['oauth_token'] = session[:token]
    #   req.params['v'] = '20161116'
    #   req.params['venueId'] = params[:venue_id]
    #   req.params['text'] = params[:tip]
    # end
    # redirect_to tips_path

    # resp = Faraday.post("https://github.com/login/oauth/access_token",
    #                     {client_id: ENV["GITHUB_CLIENT"],
    #                      client_secret: ENV["GITHUB_SECRET"],
    #                      code: params[:code]},
    #                     {'Accept' => 'application/json'})
    # session[:token] = JSON.parse(resp.body)["access_token"]

    resp = Faraday.post("https://api.github.com/user/repos",
                        {name: params[:name]},
                        {'Authorization' => "token #{session[:token]}"})
    reposit_name = JSON.parse(resp.body)["name"]
    redirect_to root_path
  end
end
