class RepositoriesController < ApplicationController


  def index

    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @user = JSON.parse(user.body)

  resp = Faraday.get("https://api.github.com/user/repos") do |req|
    req.headers['Authorization'] = 'token ' + session[:token]
    req.headers['Accept'] = 'application/json'
  end
  @results = JSON.parse(resp.body)#["response"]["list"]["listItems"]["items"]
end

end
