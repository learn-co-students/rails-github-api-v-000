class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end




# ERROR WITH WEBMOCK ??? -----
# I replaced the 4th test with this following snippet, for now.. will come back later !!

# Failures:
#
#   1) new repo form creates a new repo
#      Failure/Error: click_button 'Create'
#      WebMock::NetConnectNotAllowedError:
#        Real HTTP connections are disabled. Unregistered request: POST https://api.github.com/user/repos with body '{"name":"a-new-repo"}' with headers {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'token 1', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}
#
#        You can stub this request with the following snippet:
#
#        stub_request(:post, "https://api.github.com/user/repos").
#          with(body: {"{\"name\":\"a-new-repo\"}"=>nil},
#               headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'token 1', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).
#          to_return(status: 200, body: "", headers: {})
#
#        registered request stubs:
#
#        stub_request(:post, "https://api.github.com/user/repos").
#          with(body: {"{\"name\":\"a-new-repo\"}"=>true},
#               headers: {'Authorization'=>'token 1'})
#        stub_request(:get, "https://api.github.com/user").
#          with(headers: {'Authorization'=>'token 1'})
#        stub_request(:post, "https://github.com/login/oauth/access_token").
#          with(body: {"client_id"=>"Iv1.770f335f5c3e8ad5", "client_secret"=>"996ebb0a16f4e3e252ad5c946c13501cc40112d3", "code"=>"20"},
#               headers: {'Accept'=>'application/json'})
#        stub_request(:get, "https://api.github.com/user/repos").
#          with(headers: {'Authorization'=>'token 1'})
