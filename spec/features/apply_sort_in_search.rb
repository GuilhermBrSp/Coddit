require 'rails_helper'

describe 'As a user' do
  def create_post(title, body)
    Post.create(title: title, body: body)
  end

  it 'I can sort search results by newest' do
    post_a = create_post('Title A', 'this is body A')
    post_b = create_post('Title B', 'this is body B')
    post_c = create_post('Title C', 'this is body C')

    visit root_path

    fill_in 'query_params', with: 'this, is'
    select 'Newest', from: 'sort_criteria'
    click_button 'search button'

    expect(page.current_path).to eq search_path
    expect(page).to have_link post_a.title
    expect(page).to have_selector '.panel-body', text: post_a.body

    expect(page).to have_link post_b.title
    expect(page).to have_selector '.panel-body', text: post_b.body

    expect(page).to have_link post_c.title
    expect(page).to have_selector '.panel-body', text: post_c.body

    page.body.index('this is body C').should < page.body.index('this is body B')
    page.body.index('this is body B').should < page.body.index('this is body A')
  end

  it 'I can sort search results by most commented' do
    post_a = Post.create(title: 'Title A', body: 'this is body A', comments_counter: 10)
    post_b = Post.create(title: 'Title B', body: 'this is body B', comments_counter: 20)
    post_c = Post.create(title: 'Title C', body: 'this is body C', comments_counter: 1)

    visit root_path

    fill_in 'query_params', with: 'this, is'
    select 'Most Commented', from: 'sort_criteria'
    click_button 'search button'

    expect(page.current_path).to eq search_path
    expect(page).to have_link post_a.title
    expect(page).to have_selector '.panel-body', text: post_a.body

    expect(page).to have_link post_b.title
    expect(page).to have_selector '.panel-body', text: post_b.body

    expect(page).to have_link post_c.title
    expect(page).to have_selector '.panel-body', text: post_c.body

    page.body.index('this is body B').should < page.body.index('this is body A')
    page.body.index('this is body A').should < page.body.index('this is body C')
  end
end
