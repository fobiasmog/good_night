FactoryBot.define do
  factory :user_friend do
    association :user, factory: :user
    association :friend, factory: :user
  end
end
