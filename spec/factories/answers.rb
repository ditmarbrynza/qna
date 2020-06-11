FactoryBot.define do
  factory :answer do
    question_id { 1 }
    body { "MyText" }

    trait :invalid do
      body { nil }
    end
  end
end
