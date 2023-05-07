FactoryBot.define do
  factory :book do
    title { "MyString" }
    page_count { 1 }
    user { FactoryBot.create(:user) }
  end
end
