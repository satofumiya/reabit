require 'rails_helper'

RSpec.describe Book, type: :model do
  it "タイトルがなければ無効であること" do
    book = Book.new(title: nil)
    expect(book).not_to be_valid
    expect(book.errors[:title]).to include("を入力してください")
  end

  it "タイトルとuser_idがあれば有効であること" do
    user = FactoryBot.create(:user)
    book = Book.new(title: "Example Title", user_id: user.id)
    expect(book).to be_valid
  end
end
