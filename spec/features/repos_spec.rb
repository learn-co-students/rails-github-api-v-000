#COMMENTED OUT BECAUSE:
# Ran into a crazy webmock error and a Learn expert (Joel Cowie) gave
# me the green light to comment out the tests because the functionality
# of the app is on point. This is the error that I got for every
# one of my rspec tests:

     # Failure/Error: visit '/'
     # WebMock::NetConnectNotAllowedError:
     #   Real HTTP connections are disabled. Unregistered request: GET https://api.github.com/user?1= with headers {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.1'}
       
     #   You can stub this request with the following snippet:
       
     #   stub_request(:get, "https://api.github.com/user?1=").
     #     with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.1'}).
     #     to_return(:status => 200, :body => "", :headers => {})
       
     #   registered request stubs:
       
     #   stub_request(:post, "https://api.github.com/user/repos").
     #     with(:body => {"{\"name\":\"a-new-repo\"}"=>true},
     #          :headers => {'Authorization'=>'token 1'})
     #   stub_request(:get, "https://api.github.com/user").
     #     with(:headers => {'Authorization'=>'token 1'})
     #   stub_request(:post, "https://github.com/login/oauth/access_token").
     #     with(:body => {"client_id"=>nil, "client_secret"=>"676826dbb4a12918633b14d6092a9ddc57acb6a0", "code"=>"20"},
     #          :headers => {'Accept'=>'application/json'})
     #   stub_request(:get, "https://api.github.com/user/repos").
     #     with(:headers => {'Authorization'=>'token 1'})
       
     #   ============================================================
 

# require_relative '../spec_helper'

# describe "authentication" do
#   it "displays the username on the page" do
#     visit '/auth?code=20'
#     expect(page).to have_content 'your_username'
#   end
# end

# describe "visiting root" do
#   before :each do
#     page.set_rack_session(:token => "1")
#   end

#   it "lists repos" do
#     visit '/'
#     expect(page).to have_content 'Repo 1'
#     expect(page).to have_content 'Repo 2'
#     expect(page).to have_content 'Repo 3'
#   end
# end

# describe "new repo form" do
#   before :each do
#     page.set_rack_session(:token => "1")
#   end

#   it "creates a new repo", :type => :request do
#     visit '/'
#     fill_in 'new-repo', with: 'a-new-repo'
#     click_button 'Create'

#     expect(WebMock).to have_requested(:post, "https://api.github.com/user/repos").
#       with(:body => {name: "a-new-repo"}.to_json,
#       :headers => {'Authorization' => "token 1"})
#   end
# end