require 'rails_helper'

describe 'As a User', js: true do
  def create_post(title, body, tags_list)
    Post.create(title: title, body: body, tag_list: tags_list)
  end

  it 'I can subscribe for a subject for the first time informing my email' do
    post_a = create_post('Title A', 'Body A', 'tag1,tag2,tag3')
    post_b = create_post('Title B', 'Body B', 'tag0')

    visit root_path

    find('.tag1_tag').click
    expect(page).to have_selector '.modal-body', text: 'You must enter your e-mail if you want to be notified about updates on this subject.'
    fill_in 'user_email', with: 'user_email@example.com'
    click_button 'confirm_email_register'
    expect(page).to have_selector '.modal-body', text: 'You will be notified when new posts with this subject appear on our website :)'
    expect(Subscription.last.tag_id).to eq Tag.find_by(name: 'tag1').id
    expect(Subscription.last.email).to eq 'user_email@example.com'
  end

  it 'I can subscribe for multiple subjects just informing my email for the first subscription' do
    post_a = create_post('Title A', 'Body A', 'tag1,tag2,tag3')
    post_b = create_post('Title B', 'Body B', 'tag0')

    visit root_path

    find('.tag1_tag').click
    expect(page).to have_selector '.modal-body', text: 'You must enter your e-mail if you want to be notified about updates on this subject.'
    fill_in 'user_email', with: 'user_email@example.com'
    click_button 'confirm_email_register'
    expect(page).to have_selector '.modal-body', text: 'You will be notified when new posts with this subject appear on our website :)'
    expect(Subscription.last.tag_id).to eq Tag.find_by(name: 'tag1').id
    expect(Subscription.last.email).to eq 'user_email@example.com'

    find('.close').click

    find('.tag2_tag').click
    expect(page).to have_selector '.modal-body', text: 'Would you like to be notified about updates to this topic?'

    click_button 'confirm_subscription'
    expect(page).to have_selector '.modal-body', text: 'You will be notified when new posts with this subject appear on our website :)'
    expect(Subscription.last.tag_id).to eq Tag.find_by(name: 'tag2').id
    expect(Subscription.last.email).to eq 'user_email@example.com'
  end

  it 'I can not subscribe for the same tag more than one time' do
    post_a = create_post('Title A', 'Body A', 'tag1,tag2,tag3')
    post_b = create_post('Title B', 'Body B', 'tag0')

    visit root_path

    find('.tag3_tag').click
    expect(page).to have_selector '.modal-body', text: 'You must enter your e-mail if you want to be notified about updates on this subject.'
    fill_in 'user_email', with: 'user_email@example.com'
    click_button 'confirm_email_register'
    expect(page).to have_selector '.modal-body', text: 'You will be notified when new posts with this subject appear on our website :)'
    expect(Subscription.last.tag_id).to eq Tag.find_by(name: 'tag3').id
    expect(Subscription.last.email).to eq 'user_email@example.com'

    first_subscription_id = Subscription.last.id

    find('.close').click

    find('.tag3_tag').click

    find('.close').click
    expect(Subscription.last.id).to eq first_subscription_id
  end
  it 'I can receive an email when new posts containing tags that i have subscribed appears on the site' do
    post_a = create_post('Title A', 'Body A', 'tag1,tag2,tag3')
    post_b = create_post('Title B', 'Body B', 'tag0')

    visit root_path

    find('.tag3_tag').click
    expect(page).to have_selector '.modal-body', text: 'You must enter your e-mail if you want to be notified about updates on this subject.'
    fill_in 'user_email', with: 'user_email@example.com'
    click_button 'confirm_email_register'
    expect(page).to have_selector '.modal-body', text: 'You will be notified when new posts with this subject appear on our website :)'
    expect(Subscription.last.tag_id).to eq Tag.find_by(name: 'tag3').id
    expect(Subscription.last.email).to eq 'user_email@example.com'

    post_c = create_post('Title c', 'Body c', 'tag3')

    ActionMailer::Base.deliveries.last.tap do |mail|
       expect(mail.from).to eq(["from@example.com"])
       expect(mail.subject).to eq("New Post in Coddit!")
       expect(mail.to).to eq(['user_email@example.com'])
       expect(mail.body.encoded).to match(post_c.title)
     end

  end

end
