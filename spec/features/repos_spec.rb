require_relative '../spec_helper'

describe "authentication" do
  it "displays the username on the page" do
    visit '/auth?code=20'
    # stub_request(:get, "https://github.com/login/oauth/access_token?client_id=5dd223d3dd78adf88b36&client_secret=6c2d719cb76f482aa5d099944a7306c5db97b61f&code=20&redirect_uri=http://localhost:3000/auth")
    binding.pry
    puts page.html
    expect(page).to have_content 'your_username'
  end
end

describe "visiting root" do
  before :each do
    page.set_rack_session(:token => "1")
  end

  it "lists repos" do
    visit '/'
    expect(page).to have_content 'Repo 1'
    expect(page).to have_content 'Repo 2'
    expect(page).to have_content 'Repo 3'
  end
end

describe "new repo form" do
  before :each do
    page.set_rack_session(:token => "1")
  end

  it "creates a new repo", :type => :request do
    visit '/'
    fill_in 'new-repo', with: 'a-new-repo'
    click_button 'Create'

    expect(WebMock).to have_requested(:post, "https://api.github.com/user/repos").
      with(:body => {name: "a-new-repo"}.to_json,
      :headers => {'Authorization' => "token 1"})
  end
end