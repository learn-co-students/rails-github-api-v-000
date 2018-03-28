class RepositoriesController < ApplicationController
  
  def index
    conn = Faraday.new(:url =>"https://api.github.com")
    get_repos = conn.get "/users/#{session[:username]}/repos",{'Authorization' => "token session[:token]", 'Accept' => 'application/json'}
    repo_response = JSON.parse(get_repos. body)
    # raise get_repos.inspect
    @repos = repo_response.collect{|r| r}
  end

  def create
    
  end
end

# "access_token":"e72e16c7e42f292c6912e7710c838347ae178b4a", "scope":"repo,gist", "token_type":"bearer"