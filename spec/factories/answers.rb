FactoryBot.define do
  factory :answer do
    user
    question
    body { "answer body" }

    trait :invalid do
      body { nil }
    end
  end
end
