require 'rails_helper'

describe 'As a user', js: true do
  def create_post(title, body)
    Post.create(title: title, body: body)
  end

  it 'I can add one or more posts to my favorites list' do
    token_id = 1
    post_a = create_post('Title A', 'this is body A')
    post_b = create_post('Title B', 'this is body B')
    post_c = create_post('Title C', 'this is body C')

    visit root_path

    click_link "favorite_id_#{post_a.id}"

    click_link "favorite_id_#{post_c.id}"

    Favorite.where(token_id: token_id).each do |favorite|
      response = (favorite.post_id == post_c.id || favorite.post_id == post_a.id)
      expect(response).to eq true
    end
  end

  it 'I can remove one or more posts from my favorites list' do
    post_a = create_post('Title A', 'this is body A')

    post_b = create_post('Title B', 'this is body B')

    post_c = create_post('Title C', 'this is body C')

    visit root_path


    click_link "favorite_id_#{post_a.id}"

    click_link "favorite_id_#{post_b.id}"

    click_link "favorite_id_#{post_c.id}"


    click_link "favorite_id_#{post_a.id}"

    click_link "favorite_id_#{post_c.id}"


    expect(post_b.favorites.empty?).to eq false
    expect(post_a.favorites.empty?).to eq true
    expect(post_c.favorites.empty?).to eq true
  end

  it 'I can see my favorites list' do
    post_a = create_post('Title A', 'this is body A')

    post_b = create_post('Title B', 'this is body B')

    post_c = create_post('Title C', 'this is body C')

    visit root_path


    click_link "favorite_id_#{post_a.id}"

    click_link "favorite_id_#{post_c.id}"

    click_link 'favorites-list'

    expect(page).to have_link post_a.title, href: post_path(post_a.id)
    expect(page).to have_selector '.panel-body', text: post_a.body
    expect(page).not_to have_link post_b.title, href: post_path(post_b.id)
    expect(page).not_to have_selector '.panel-body', text: post_b.body
    expect(page).to have_link post_c.title, href: post_path(post_c.id)
    expect(page).to have_selector '.panel-body', text: post_c.body



  end

end
