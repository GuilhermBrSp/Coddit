require 'rails_helper'

describe 'As a user' do
  it 'I can create a post comment' do
    def create_post
      Post.create(title: 'Post Title', body: 'Post Body')
    end

    post = create_post

    visit post_path(post.id)

    fill_in 'Leave a Comment', with: 'Just a comment'

    click_button 'Add Comment'

    expect(page).to have_selector '.comment'

    expect(page).to have_selector '.comment-body', text: 'Just a comment'
  end

  it 'I can not create a comment with an empty body, a message describing the error should appear' do
    def create_post
      Post.create(title: 'Post Title', body: 'Post Body')
    end

    post = create_post

    visit post_path(post.id)

    click_button 'Add Comment'

    expect(page).not_to have_selector '.comment'

    expect(page).to have_selector '.alert.alert-notice', text: "You can't leave the comment in blank"
  end
end
