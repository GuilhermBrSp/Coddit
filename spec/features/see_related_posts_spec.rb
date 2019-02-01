require 'rails_helper'

describe 'As a User', js: true do
  def create_post(title, body, tags_list)
    Post.create(title: title, body: body, tag_list: tags_list)
  end

  it 'I can see related posts if there is any' do
    post_a = create_post('Title A', 'Body A', 'tag1,tag2,tag3')
    post_b = create_post('Title B', 'Body B', 'tag0')
    post_c = create_post('Title C', 'Body C', 'tag1,tag4,tag5')
    post_d = create_post('Title D', 'Body D', 'tag1,tag5')
    post_e = create_post('Title E', 'Body E', 'tag1,tag6')
    post_f = create_post('Title F', 'Body F', 'tag1,tag6,tag5')

    visit post_path(post_a.id)

    expect(page).to have_selector '#related_posts'
    expect(page).not_to have_link post_a.title, href: post_path(post_a.id)
    expect(page).not_to have_link post_b.title, href: post_path(post_b.id)
    expect(page).to have_link post_c.title, href: post_path(post_c.id)
    expect(page).to have_link post_d.title, href: post_path(post_d.id)
    expect(page).to have_link post_e.title, href: post_path(post_e.id)
    expect(page).to have_link post_f.title, href: post_path(post_f.id)
  end

  it 'I can not see any related posts if there is none' do
    post_a = create_post('Title A', 'Body A', 'tag1,tag2,tag3')
    post_b = create_post('Title B', 'Body B', 'tag0')
    post_c = create_post('Title C', 'Body C', 'tag1,tag4,tag5')
    post_d = create_post('Title D', 'Body D', 'tag1,tag5')
    post_e = create_post('Title E', 'Body E', 'tag1,tag6')
    post_f = create_post('Title F', 'Body F', 'tag1,tag6,tag5')

    visit post_path(post_b.id)

    expect(page).not_to have_selector '#related_posts'

  end

end
