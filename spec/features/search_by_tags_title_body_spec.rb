require 'rails_helper'

describe 'As a user' do
  def create_posts
    Post.create(title: 'Rails Development Tips', body: 'This posts talks about ruby on rails quick tips', tag_list: 'rails,   ruby, development  ')
    Post.create(title: 'Neural Networks', body: 'This post talks about machine Learning', tag_list: 'machine learning,   neural networks, artificial inteligence  ')
    Post.create(title: 'Blockchain in web systems', body: 'This posts talks about blockchain', tag_list: 'chain,   blockchain, web, systems  ')
    Post.create(title: 'The future of the software engineering', body: 'This posts talks about software engineering', tag_list: 'software,   systems, engineering  ')
    Post.create(title: 'Why Computacional Applied Math Is So Cool', body: 'This posts talks about computacional applied math', tag_list: 'math,   it, computers, information technology  ')
  end

  it 'I can make a search by tags' do
    create_posts

    visit root_path

    fill_in 'query_params', with: 'systems'
    click_button 'search button'

    expect(page.current_path).to eq search_path

    expect(page).to have_link 'Blockchain in web systems'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about blockchain'

    expect(page).to have_link 'The future of the software engineering'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about software engineering'

    expect(page).not_to have_link 'Rails Development Tips'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about ruby on rails quick tips'

    expect(page).not_to have_link 'Neural Networks'
    expect(page).not_to have_selector '.panel-body', text: 'This post is going to talk about machine Learning'

    expect(page).not_to have_link 'Why Computacional Applied Math Is So Cool'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about computacional applied math'
  end

  it 'I can make a search by title' do
    create_posts

    visit root_path

    fill_in 'query_params', with: 'block'
    click_button 'search button'

    expect(page.current_path).to eq search_path

    expect(page).to have_link 'Blockchain in web systems'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about blockchain'

    expect(page).not_to have_link 'The future of the software engineering'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about software engineering'

    expect(page).not_to have_link 'Rails Development Tips'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about ruby on rails quick tips'

    expect(page).not_to have_link 'Neural Networks'
    expect(page).not_to have_selector '.panel-body', text: 'This post is going to talk about machine Learning'

    expect(page).not_to have_link 'Why Computacional Applied Math Is So Cool'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about computacional applied math'
  end

  it 'I can make a search by body' do
    create_posts

    visit root_path

    fill_in 'query_params', with: 'talks'
    click_button 'search button'

    expect(page.current_path).to eq search_path

    expect(page).to have_link 'Blockchain in web systems'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about blockchain'

    expect(page).to have_link 'The future of the software engineering'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about software engineering'

    expect(page).to have_link 'Rails Development Tips'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about ruby on rails quick tips'

    expect(page).to have_link 'Neural Networks'
    expect(page).to have_selector '.panel-body', text: 'This post talks about machine Learning'

    expect(page).to have_link 'Why Computacional Applied Math Is So Cool'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about computacional applied math'
  end

  it 'I can make a search by multiple elements' do
    create_posts

    visit root_path

    fill_in 'query_params', with: 'applied, math, talks  , information technology'
    click_button 'search button'

    expect(page.current_path).to eq search_path

    expect(page).not_to have_link 'Blockchain in web systems'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about blockchain'

    expect(page).not_to have_link 'The future of the software engineering'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about software engineering'

    expect(page).not_to have_link 'Rails Development Tips'
    expect(page).not_to have_selector '.panel-body', text: 'This posts talks about ruby on rails quick tips'

    expect(page).not_to have_link 'Neural Networks'
    expect(page).not_to have_selector '.panel-body', text: 'This post talks about machine Learning'

    expect(page).to have_link 'Why Computacional Applied Math Is So Cool'
    expect(page).to have_selector '.panel-body', text: 'This posts talks about computacional applied math'
  end

  it 'I can make a search with blank parameters, a message should appear to me' do
    create_posts

    visit root_path

    fill_in 'query_params', with: ''
    click_button 'search button'

    expect(page).to have_selector '.alert', text: 'Sorry, there were no results for Blank value'
  end

  it 'I can make a search with no posts to be found, a message should appear to me' do
    create_posts

    visit root_path

    fill_in 'query_params', with: 'Computacional Vision'
    click_button 'search button'

    expect(page).to have_selector '.alert', text: "Sorry, there were no results for 'Computacional Vision'"
  end
end
