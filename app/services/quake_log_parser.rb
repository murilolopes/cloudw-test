class QuakeLogParser
  attr_reader :log_file

  def initialize(file = nil)
    @log_file = File.open(file || "#{Rails.root}/public/qgames.log", "r")
  end

  def call
    @game = {}
    @in_game = false
    @start_game = 0
    @end_game = 0

    log_file.each_with_index do |line, index|
      init_game(line) if is_initing_game?(line)
      create_player(line) if is_creating_player?(line)
      changing_player_info(line) if is_changing_player_info?(line)
      adding_kills(line) if is_killing_player?(line)
      shutdown_game(line) if is_shutting_down_game?(line)
    end
  end

  def self.call(file)
    new(file).call
  end

  private

  def init_game(line)
    @in_game = true
    @game = Game.create(name: line.split("\\")[12])
    @start_game = convert_game_time_to_seconds(line.split[0])
  end

  def is_initing_game?(line)
    line.scan(/ InitGame: /).length.positive? && !@in_game
  end

  def create_player(line)
    Player.create(code: line.split[2], game_id: @game.id)
  end

  def is_creating_player?(line)
    line.scan(/ ClientConnect/).length.positive? && @in_game
  end

  def changing_player_info(line)
    player = @game.players.where(code: line.split[2]).first
    player.update(name: line.split("\\")[1]) if player.present?
  end

  def is_changing_player_info?(line)
    line.scan(/ ClientUserinfoChanged/).length.positive? && @in_game
  end

  def adding_kills(line)
    assassin = @game.players.where(code: line.split[2]).first if was_not_world_who_killed?(line)
    victim = @game.players.where(code: line.split[3]).first

    death = @game.deaths.create!(assassin_id: assassin&.id, victim_id: victim.id, cause: line.split.last)
  end

  def is_killing_player?(line)
    line.scan(/ Kill:/).length.positive? && @in_game
  end

  def was_not_world_who_killed?(line)
    !!line.scan(/ <world> /).length
  end

  def shutdown_game(line)
    @in_game = false
    @end_game = convert_game_time_to_seconds(line.split[0])
    @game.update!(duration: @end_game - @start_game)
  end

  def is_shutting_down_game?(line)
    line.scan(/ ShutdownGame:/).length.positive? && @in_game
  end

  def convert_game_time_to_seconds(hour)
    hour = hour.split(":")
    (hour[0].to_i * 60) + hour[1].to_i
  end
end