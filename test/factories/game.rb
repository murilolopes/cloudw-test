# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    name { Faker::name }
    duration { Faker::Number.between(0, 120) }
  end
end
