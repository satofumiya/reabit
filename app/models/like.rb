class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }
  validate :cannot_like_own_post

  private

  def cannot_like_own_post
    errors.add(:base, "自分の投稿にいいねをつけることはできません.") if user_id == post.user_id
  end
end
