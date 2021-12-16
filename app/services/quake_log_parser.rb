class QuakeLogParser
  attr_reader :log_file

  def initialize
    @log_file = File.open("#{Rails.root}/public/qgames.log", "r")
  end

  def call
    log_file.each_with_index do |line, index|
      game = {}
      in_game = false

      init_game(game, in_game) if initing_game?(game, line, in_game)

      if line.scan(/ ClientConnect/).length.positive? && in_game
        Player.create(code: line.split[2], game_id: game.id)
      end

      if line.scan(/ ClientUserinfoChanged/).length.positive? && in_game
        player = game.players.where(code: line.split[2]).first
        player.update(name: line.split("\\")[1]) if !player.nil?
      end

      if line.scan(/ ClientDisconnect/).length.positive? && in_game
        # game.players.where(code: line.split[2]).first.destroy
      end

      if line.scan(/ Kill:/).length.positive? && in_game
        assassin = game.players.where(code: line.split[2]).first if line.split[2] != "1022"
        victim = game.players.where(code: line.split[3]).first

        death = game.deaths.create(assassin_id: assassin&.id, victim_id: victim.id, cause: line.split.last)
        death.save
      end


      if line.scan(/ ShutdownGame:/).length.positive? && in_game
        in_game = false
      end
    end
  end

  def init_game
    in_game = true
    game = Game.create(name: line.split("\\")[12])
  end

  def initing_game?(line, in_game)
    line.scan(/ InitGame: /).length.positive? && !in_game
  end
end