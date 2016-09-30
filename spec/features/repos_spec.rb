require_relative '../spec_helper'

describe "authentication" do
  it "displays the username on the page" do
    visit '/auth?code=20'
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
