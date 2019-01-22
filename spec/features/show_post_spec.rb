require 'rails_helper'

describe 'As a user' do
  it 'I want to click on the post and see its content' do
    def create_post
      Post.create( title:"Post Title", body:"Post Body" )
    end

    post = create_post

    visit posts_path

    click_link post.title or click_link 'Show'

    expect(page.current_path).to eq post_path(post.id)

    expect(page).to have_selector '.title', text: post.title

    expect(page).to have_selector '.lead', text: post.body

  end
end
