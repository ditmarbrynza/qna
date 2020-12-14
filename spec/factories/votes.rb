# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    click { 1 }
    user { nil }
    votable { nil }
  end
end
