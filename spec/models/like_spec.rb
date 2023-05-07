require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  describe "バリデーションについて" do
    it "user_id と post_id の組み合わせが一意である場合は、有効であること" do
      like = Like.new(user_id: user.id, post_id: post.id)
      expect(like).to be_valid
    end

    it "user_id と post_id の組み合わせが既に存在する場合は、無効であること" do
      FactoryBot.create(:like, user_id: user.id, post_id: post.id)
      like = Like.new(user_id: user.id, post_id: post.id)
      expect(like).to be_invalid
      expect(like.errors[:user_id]).to include("はすでに存在します")
    end

    it "user_id が post.user_id と等しい場合は、無効であること" do
      like = Like.new(user_id: user.id, post_id: post.id, created_at: Time.now)
      like.user_id = post.user_id
      like.valid?
      expect(like.errors[:base]).to include("自分の投稿にいいねをつけることはできません.")
    end
  end
end
