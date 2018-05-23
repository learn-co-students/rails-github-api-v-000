class GithubService
  attr_accessor :token, :links

  def initialize(access_hash=nil)
    self.token = access_hash["access_token"] if access_hash
  end

  def authenticate!(client_id, client_secret, code)
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers = {"Accept": "application/json"}
      req.body = {
        'client_id': client_id,
        'client_secret': client_secret,
        'code': code
      }
    end
    access_hash = JSON.parse(resp.body)
    self.token = access_hash["access_token"]
  end

  def get_username
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {
        "Authorization": "token #{self.token}",
        "Accept": "application/json"
      }
    end
    JSON.parse(resp.body)['login']
  end

  def get_repos(page=nil)
    resp = Faraday.get("https://api.github.com/user/repos#{page if !!page.match(/\d/)}") do |req|
      req.headers = {"Authorization": "token #{self.token}", "Accept": "application/json"}
    end
    self.links = resp.headers['link']
    JSON.parse(resp.body)
  end

  def create_repo(name)
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {
        "Authorization": "token #{self.token}",
        "Accept": "application/json"
      }
      req.body = {'name': name}.to_json
    end
    binding.pry
  end
end
