require 'rails_helper'

describe 'As a user' do
  it 'I can create a post' do
    visit root_path

    click_link 'New Post'

    expect(page.current_path).to eq new_post_path

    fill_in 'Title', with: 'Test Title'
    fill_in 'Body', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'

    click_button 'Create Post'

    expect(Post.count).to eq 1
    expect(Post.last).to have_attributes(title: 'Test Title', body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

  end

  it 'I can create a post' do
    visit root_path

    click_link 'New Post'

    expect(page.current_path).to eq new_post_path
    fill_in 'Title', with: 'Test Title'
    click_button 'Create Post'
    expect(Post.count).to eq 0

    expect(page).to have_selector '#error_explanation'
    expect(page).to have_selector 'li', text:"Body can't be blank"


  end

end
