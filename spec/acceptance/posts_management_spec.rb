require 'base'

describe 'Posts management', type: :feature, js: true do

  it 'creates a new post with tags when authenticated' do
    visit '/'
    expect(page).to have_content('Looks like this is a fresh install of Scanty.')
    click_link 'Log in'
    fill_in 'password', with: '123'
    click_button 'Login'
    click_link 'New post'
    fill_in 'title', with: 'A test post'
    fill_in 'tags', with: 'tag1 tag2'
    fill_in 'body', with: 'A body body'
    click_button 'Save'
    expect(page).to have_content('A test post')
    click_link 'tag1'
    expect(page).to have_content('Posts tagged tag1')
  end

  it 'can not create posts when not authenticated' do
    visit '/'
    expect(page).to have_content('Looks like this is a fresh install of Scanty.')
    expect(page).to_not have_content('New post')
    visit '/posts/new'
    expect(page).to have_content('Not authorized')
  end

end
