class RepositoriesController < ApplicationController
  def index
    response = Faraday.get("https://api.github.com/users/#{session[:username]}/repos")
    @repos = JSON.parse(response.body)
  end

  # params form
    # {"utf8"=>"✓", 
    #  "authenticity_token"=>"8BNLEbmMwqBA7nMSUfzOdhC4/PSp/1dcUEol+8S/9tlL9cfSE9s8Bnhyv1kNpo3F3VwfGHeLN97lryCzjE20Qg==", 
    # "name"=>"test-repo", 
    # "commit"=>"Create", 
    # "controller"=>"repositories", 
    # "action"=>"create"}
  def create
    #raise params.inspect
  end
end
