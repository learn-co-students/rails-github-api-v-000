class RepositoriesController < ApplicationController

  before_action :authenticate_user

  def index
    resp = Faraday.get "https://api.github.com/user" do |req|
      req.params['access_token'] = session[:token]
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(resp.body)
    @username = body["login"]


    repo_resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.params['access_token'] = session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(repo_resp.body)


    # client = Octokit::Client.new(:access_token => session[:token])
    # @repos = client.repos
    #
    # last_response = client.last_response
    # number_of_pages = last_response.rels[:last].href.match(/page=(\d+).*$/)[1]
    #
    # @prev_page_href = client.last_response.rels[:prev] ? client.last_response.rels[:prev].href : nil
    # @next_page_href = client.last_response.rels[:next] ? client.last_response.rels[:next].href : nil

  end


  def create
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    access_token = session[:token]

    post_repo_resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.body = { 'access_token': access_token, 'name': params[:name].to_json }
      req.headers['Accept'] = 'application/json'

      # req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      # req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      # req.params['access_token'] = session[:token]
      # req.params['name'] = params[:name].to_json
    end
    redirect_to '/'
  end

end
