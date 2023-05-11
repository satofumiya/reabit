require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:book) { FactoryBot.create(:book) }

  describe "トップページ" do
    let!(:post1) { FactoryBot.create(:post, user: user1, book: book, content: "This is the first post.") }
    let!(:post2) { FactoryBot.create(:post, user: user1, book: book, content: "This is the second post.") }

    it "投稿のタイトル、作成者、投稿内容が正常に表示されていること" do
      visit root_path
      expect(page).to have_content post1.book.title
      expect(page).to have_content post1.user.name
      expect(page).to have_content post1.content
      expect(page).to have_content post2.book.title
      expect(page).to have_content post2.user.name
      expect(page).to have_content post2.content
    end

    context "投稿者と違うユーザーがログインしている場合" do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user2.email
        fill_in "user[password]", with: user2.password
        click_button "ログイン"
      end

      it "いいねが表示し、正常に操作できること" do
        visit root_path
        within("#post_#{post1.id}") do
          expect(page).to have_button "いいね"
          click_button 'いいね'
        end
        expect(page).to have_content "いいね済みです。"
      end
    end

    context "投稿者と同じユーザーがログインしている場合" do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user1.email
        fill_in "user[password]", with: user1.password
        click_button "ログイン"
      end

      it "いいねが表示せず、いいねを押すことができないこと" do
        visit root_path
        within("#post_#{post1.id}") do
          expect(page).not_to have_button "いいね"
        end
      end
    end

    context "ログインしていない場合" do
      it "いいねボタンが表示されていないこと" do
        visit root_path
        within("#post_#{post1.id}") do
          expect(page).not_to have_button 'いいね'
        end
      end
    end
  end
end
