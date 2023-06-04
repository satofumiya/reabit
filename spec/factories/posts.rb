FactoryBot.define do
  factory :post do
    content { "MyText" }
    user { FactoryBot.create(:user) }
    book { FactoryBot.create(:book) }
    trait :with_likes do
      after(:create) do |post|
        create_list(:like, 3, post: post)
      end
    end
  end
end
