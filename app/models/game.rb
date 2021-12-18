class Game < ApplicationRecord
  has_many :players
  has_many :deaths

  validates :name, presence: true

  def report
    kills = []

    players.each do |p|
      kills << { "#{p.name}": p.kills.count }
    end

    {
      name: name,
      total_kills: deaths.size,
      players: players.pluck(:name),
      kills: kills
    }
  end

  def kills_by_means
    causes = []

    deaths.pluck(:cause).uniq.each do |cause|
      causes << { "#{cause}": deaths.where(cause: cause).count }
    end

    causes
  end
end
