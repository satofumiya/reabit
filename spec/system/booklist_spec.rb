require 'rails_helper'

RSpec.describe '本棚', type: :system , js: true do
  let!(:user) { FactoryBot.create(:user) }
  let!(:book) { FactoryBot.create(:book, user: user)}

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  it '後で読む本に本を追加できること' do
    visit booklists_path
    save_and_open_page
    fill_in 'booktitle', with: 'Test Book'
    binding.pry
    click_button '読みたい本を追加する'
    expect(page).to have_content('後で読む本')
    expect(page).to have_content('Test Book')
  end

  it '今読む本に本を追加できること' do
    visit booklists_path
    expect(page).to have_content('自分の読書状況を整理しましょう')
    click_button 'この本を読む', match: :first
    expect(page).to have_content('今読む本')
    expect(page).to_not have_content('後で読む本')
  end

  it '最近読んだ本に追加できること' do
    visit booklists_path
    expect(page).to have_content('自分の読書状況を整理しましょう')
    click_button '読み終わりました！', match: :first
    expect(page).to have_content('最近読んだ本')
    expect(page).to_not have_content('今読む本')
  end
end
