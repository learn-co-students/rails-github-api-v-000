class RepositoriesController < ApplicationController
  def index
    # resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
    #   req.params['oauth_token'] = session[:token]
    #   req.params['v'] = '20160201'
    # end
    # @results = JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

  def create
    # resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
    #   req.params['oauth_token'] = session[:token]
    #   req.params['v'] = '20160201'
    #   req.params['venueId'] = params[:venue_id]
    #   req.params['text'] = params[:tip]
    # end
    # redirect_to tips_path
  end
end
