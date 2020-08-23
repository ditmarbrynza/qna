# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    user
    title { 'question title' }
    body { 'question body' }

    trait :invalid do
      body { nil }
    end
  end
end
