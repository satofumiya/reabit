require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーションについて" do
    it "正常に投稿ができること" do
      user = FactoryBot.create(:user)
      book = FactoryBot.create(:book, user: user)
      post = FactoryBot.build(:post, user: user, book: book)
      expect(post).to be_valid
    end

    it "contentがない場合、無効であること" do
      post = FactoryBot.build(:post, content: nil)
      post.valid?
      expect(post.errors[:content]).to include("を入力してください")
    end

    it "contentが長すぎる場合、無効であること" do
      post = FactoryBot.build(:post, content: "a" * 145)
      post.valid?
      expect(post.errors[:content]).to include("は144文字以内で入力してください")
    end
  end

  describe "アソシエーションについて" do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Bookモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:book).macro).to eq :belongs_to
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:likes).macro).to eq :has_many
      end

      it '投稿が削除されたら、紐づくいいねも削除される' do
        post = FactoryBot.create(:post)
        user = FactoryBot.create(:user)
        like = FactoryBot.create(:like, post: post, user: user)
        expect { post.destroy }.to change(Like, :count).by(-1)
      end
    end
  end
end
