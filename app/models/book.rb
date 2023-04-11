class Book < ApplicationRecord
  belongs_to :user
  has_one :post, dependent: :destroy
  accepts_nested_attributes_for :post
end
