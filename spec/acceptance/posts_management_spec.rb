require 'base'

describe 'Posts management', type: :feature, js: true do

  describe 'creating posts' do
    context 'when authenticated' do
      before do
        visit '/'
        expect(page).to have_content('Looks like this is a fresh install of Scanty.')
        click_link 'Log in'
        fill_in 'password', with: '123'
        click_button 'Login'
      end

      it 'should be able to add tags' do
        click_link 'New post'
        fill_in 'title', with: 'A test post'
        fill_in 'tags', with: 'tag1 tag2'
        fill_in 'body', with: 'A body body'
        click_button 'Save'
        expect(page).to have_content('A test post')
        click_link 'tag1'
        expect(page).to have_content('Tagged: tag1')
      end

      it 'should be able to specify the creation date' do
        click_link 'New post'
        fill_in 'date', with: '2014-12-01'
        fill_in 'title', with: 'A test post'
        fill_in 'tags', with: 'tag1 tag2'
        fill_in 'body', with: 'A body body'
        click_button 'Save'
        expect(page).to have_content('A test post')
        expect(page).to have_content('tags: tag1 tag2')

        expect(Scanty::Post.first.created_at.to_date).to eq DateTime.parse('2014-12-01')
      end
    end

    context 'when not authenticated' do
      it 'should not create a post' do
        visit '/'
        expect(page).to have_content('Looks like this is a fresh install of Scanty.')
        expect(page).to_not have_content('New post')
        visit '/posts/new'
        expect(page).to have_content('Not authorized')
      end
    end
  end

end
