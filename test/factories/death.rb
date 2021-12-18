# frozen_string_literal: true

FactoryBot.define do
  factory :death do
    assassin_id { nil }
    victim_id { 1 }
    cause { "MOD_ROCKET" }
    game
  end
end
