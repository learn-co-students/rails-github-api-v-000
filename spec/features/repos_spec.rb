require_relative '../spec_helper'



describe 'visiting root' do
  before :each do
    page.set_rack_session(token: '1')
  end

  it 'lists repos' do
    visit '/'
    expect(page).to have_content 'Repo 1'
    expect(page).to have_content 'Repo 2'
    expect(page).to have_content 'Repo 3'
  end
end
