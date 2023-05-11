FactoryBot.define do
  factory :sleep_record do
    user
    trait :completed do
      duration { 10.hours.seconds.to_i }
      stopped_at { created_at + 10.hours }
      created_at { FFaker::Time.datetime }
    end
  end
end
