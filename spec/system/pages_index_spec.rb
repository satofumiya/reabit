require 'rails_helper'

RSpec.describe 'Homepage', type: :system do
  before do
    visit root_path
  end

  context 'ユーザーがサインインしていない場合' do
    it 'サインインしていない場合の文章が表示されていること' do
      expect(page).to have_content('Reabitは読書習慣をサポートするアプリです。')
      expect(page).to have_content('どんな機能があるか試してみましょう')
      expect(page).to have_link('簡単ログイン')
    end

    it 'サインインしている場合の文章が表示されないこと' do
      expect(page).not_to have_content('まずは投稿から読んで見たい本を探してみましょう')
      expect(page).not_to have_content('1、本を見つけたらBookListで自分が気になった本を登録しましょう。')
      expect(page).not_to have_content('2、BookListでは「今読んでいる本」「読み終わった本」「後で読む本」を確認することができます。')
      expect(page).not_to have_content('3、本を読み終わったらどんな人におすすめか本について学んだこと等を紹介してみましょう')
    end

    it '新規投稿、人気投稿が表示されていること' do
      expect(page).to have_content('人気投稿')
      expect(page).to have_content('新規投稿')
    end
  end

  context 'ユーザーがサインインしている場合' do
    before do
      user = create(:user)
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit root_path
    end

    it 'サインインしている場合の文章が表示されていること' do
      expect(page).to have_content('Reabitは読書習慣をサポートするアプリです。')
      expect(page).to have_content('まずは投稿から読んで見たい本を探してみましょう')
      expect(page).to have_content('1、本を見つけたらBookListで自分が気になった本を登録しましょう。')
      expect(page).to have_content('2、BookListでは「今読んでいる本」「読み終わった本」「後で読む本」を確認することができます。')
      expect(page).to have_content('3、本を読み終わったらどんな人におすすめか本について学んだこと等を紹介してみましょう')
    end

    it 'サインインしていない場合の文章が表示されないこと' do
      expect(page).not_to have_content('どんな機能があるか試してみましょう')
      expect(page).not_to have_link('簡単ログイン')
    end

    it '人気投稿、新規投稿が表示されていること' do
      expect(page).to have_content('人気投稿')
      expect(page).to have_content('新規投稿')
    end
  end
end
