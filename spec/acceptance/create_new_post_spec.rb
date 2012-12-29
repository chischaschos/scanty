require 'base'

describe 'Create a new post', type: 'acceptance', js: true do

  specify do
    visit '/'
    page.should have_content('Looks like this is a fresh install of Scanty.')
    click_link 'Log in'
    fill_in 'password', with: '123'
    click_button 'Login'
    click_link 'New post'
    fill_in 'title', with: 'A test post'
    fill_in 'tags', with: 'tag1 tag2'
    fill_in 'body', with: 'A body body'
    click_button 'Save'
    page.should have_content('A test post')
    click_link 'tag1'
    page.should have_content('Posts tagged tag1')
  end

end
