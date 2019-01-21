require 'rails_helper'

describe 'As a user' do

  it 'I can click on homepage and see the post listing' do
    def create_post(title,body)
      Post.create( title: title, body: body )
    end

    posts = [create_post("Title A", "this is body A"),
             create_post("Title B", "this is body B"),
             create_post("Title C", "this is body C")]

    visit root_path

    click_link 'Home'


    posts.each do |post|
      expect(page).to have_link post.title, href: post_path(post.id)
      expect(page).to have_selector '.panel-body', text: post.body
    end

  end
end
