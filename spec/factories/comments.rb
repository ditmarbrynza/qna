# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commentable { nil }
    user
    text { 'CommentBody' }

    trait :invalid do
      text { nil }
    end
  end
end
