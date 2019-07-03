class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get("https://api.github.com/user",
                        {},
                        {'Authorization' => "token #{session[:token]}",
                         'Accept' => 'application/json'}
                       )
    @username = JSON.parse(resp.body)["login"]

    response = Faraday.get("https://api.github.com/user/repos",
                          {},
                          {'Authorization' => "token #{session[:token]}",
                           'Accept' => 'application/json'}
                         )
    @repos = JSON.parse(response.body)
  end

end
