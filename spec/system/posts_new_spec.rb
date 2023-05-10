require 'rails_helper'

RSpec.describe "投稿ページ", type: :system do
  before do
    @user = create(:user)
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "ログイン"
    @book = create(:book, user: @user)
    visit new_post_path(book_id: @book.id)
  end

  it "正常に投稿を作成することができること" do
    fill_in 'post[content]', with: "この本はとてもおすすめです"
    click_button "投稿する"
    expect(page).to have_content "投稿が作成されました"
  end

  it "無効な投稿に対してエラーメッセージが表示されること" do
    click_button "投稿する"
    expect(page).to have_content "投稿の作成に失敗しました"
  end

  it "ログインしていないユーザーがアクセスした場合、ログインページにリダイレクトされること" do
    click_link_or_button('ログアウト', match: :first)
    visit new_post_path(book_id: @book.id)
    expect(page).to have_current_path(new_user_session_path)
  end

  it "対応する本のタイトルの表示ができること" do
    expect(page).to have_content @book.title
  end
end
