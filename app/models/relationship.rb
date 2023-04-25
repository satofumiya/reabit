class Relationship < ApplicationRecord
  belongs_to :follow, class_name: "User"
  belongs_to :followed, class_name: "User"

  validate :cannot_follow_myself

  private

  def cannot_follow_myself
    errors.add(:followed, "自分をフォローすることは出来ません！") if follower_id == followed_id
  end
end
