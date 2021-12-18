# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    name { Faker::name }
    game
  end
end
