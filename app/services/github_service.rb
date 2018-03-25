class GithubService

  def authenticate!(client_id, client_secret, code)
    resp = Faraday.post "https://github.com/login/oauth/access_token", 
      {client_id: client_id, client_secret: client_secret, code: code}, 
      {"Accept" => "application/json"}  

    body = JSON.parse(resp.body)
    @access_token = body["access_token"]    
  end

end