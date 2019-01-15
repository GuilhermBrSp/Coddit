require 'rails_helper'

describe 'As a user', js: true, type: :feature do
  it 'I can see the homepage' do
    visit '/'

    within('h1') { expect(page).to have_content 'Hello Codinhos' }
  end
end
