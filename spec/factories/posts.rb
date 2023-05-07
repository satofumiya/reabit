FactoryBot.define do
  factory :post do
    content { "MyText" }
    user { FactoryBot.create(:user) }
    book { FactoryBot.create(:book) }
  end
end
