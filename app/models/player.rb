class Player < ApplicationRecord
  belongs_to :game
  has_many :kills, :foreign_key => "assassin_id", :class_name => "Death"
  has_many :deaths, :foreign_key => "victim_id", :class_name => "Death"
end
