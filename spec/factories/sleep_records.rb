FactoryBot.define do
  factory :sleep_record do
    user

    trait :completed_past_month do
      duration { 10.hours.seconds.to_i }
      stopped_at { created_at + 10.hours }
      created_at { Time.now - 1.month }
    end

    trait :completed_past_week do
      duration { 10.hours.seconds.to_i }
      stopped_at { created_at + 10.hours }
      created_at { Time.now.beginning_of_week - 2.days }
    end

    trait :completed_this_week do
      duration { 10.hours.seconds.to_i }
      stopped_at { created_at + 10.hours }
      created_at { Time.now.beginning_of_week + 2.days }
    end
  end
end
