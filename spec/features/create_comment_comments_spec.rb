require 'rails_helper'

describe 'As a user' , js:true do
  it 'I can create a comment comment' do
    def create_post
      post_ = Post.create(title: 'Post Title', body: 'Post Body')
    end

    post = create_post
    post.comments.create(body:"This is a post comment")

    visit post_path(post.id)

    expect(post.comments.count).to eq 1

    find("[class='reply-button']").click

    click_button 'SHDSAH'













  end
end
