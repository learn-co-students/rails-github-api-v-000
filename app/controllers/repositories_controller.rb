class RepositoriesController < ApplicationController

  def index
  conn = Faraday.new(url: 'https://api.github.com/user/repos')
  resp = conn.get do |req|
    req.headers = { Accept: 'application/json',
                    Authorization: "token #{session[:token]}" }
  end
  @repos = JSON.parse(resp.body)
end

def create
  resp = Faraday.new(url: 'https://api.github.com/user/repos') #get the repos
  resp.post do |req| #call POST on the repos acquired the line prior
    req.headers = { Accept: 'application/json',
                    Authorization: "token #{session[:token]}" }
    req.body = { name: params[:name] }.to_json
  end
  redirect_to root_path
end

end
