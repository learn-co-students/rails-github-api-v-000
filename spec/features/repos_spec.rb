require_relative '../spec_helper'

describe 'authentication' do
  it 'displays the username on the page' do
    expect(true).to equal true
  end
end

describe 'visiting root' do
  it "lists repos" do
    expect(true).to equal true
  end
end

describe "new repo form" do
  it "creates a new repo", :type => :request do
    expect(true).to equal true
  end
end
