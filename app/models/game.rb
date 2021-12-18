class Game < ApplicationRecord
  has_many :players
  has_many :deaths

  validates :name, presence: true

  def report
    kills = []
    players.each do |p|
      kills << { "#{p.name}": p.kills.count }
    end

    report_object(kills)
  end

  def kills_by_means
    causes = []
    deaths.pluck(:cause).uniq.each do |cause|
      causes << { "#{cause}": deaths.where(cause: cause).count }
    end
    causes
  end

  private

  def report_object(kills)
    {
      name: name,
      total_kills: deaths.size,
      players: players.pluck(:name),
      kills: kills
    }
  end
end
