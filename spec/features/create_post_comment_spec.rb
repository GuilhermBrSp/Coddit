require 'rails_helper'

describe 'As a user', js:true do
  it 'I can create a post comment' do
    def create_post
      Post.create(title: 'Post Title', body: 'Post Body')
    end

    post = create_post

    visit post_path(post.id)

    fill_in 'post_comment_body', with: 'Just a comment'

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
    
    expect(post.comments.empty?).to eq true
  end
end
