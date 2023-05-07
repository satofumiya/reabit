class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :likes, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 144 }
end
