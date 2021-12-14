class QuakeLogParser
  attr_reader :log_file

  def initialize
    @log_file = File.open("#{Rails.root}/public/qgames.log", "r")
  end

  def call
    kills = []
    items = []
    exits = []
    scores = []
    initGame = []
    shutdownGame = []
    lol = []
    serverLogs = []
    log_file.each_with_index do |line, index|
      kills << line if line.scan(/ Kill: /).length.positive?
      items << line if line.scan(/ Item: /).length.positive?
      exits << line if line.scan(/ Exit: /).length.positive?
      scores << line if line.scan(/ score: /).length.positive?
      initGame << line if line.scan(/ InitGame: /).length.positive?
      shutdownGame << line if line.scan(/ ShutdownGame:/).length.positive?
      lol << line if line.scan(/ ------------------------------------------------------------/).length.positive?
      serverLogs << line if line.scan(/ Client/).length.positive?
    end

    puts "Kills: #{kills.size}"
    puts "Items: #{items.size}"
    puts "Exits: #{exits.size}"
    puts "Scores: #{scores.size}"
    puts "Init: #{initGame.size}"
    puts "Shutdowns: #{shutdownGame.size}"
    puts "Empty lines: #{lol.size}"
    puts "Server logs: #{serverLogs.size}"
    puts "Total: #{kills.size + items.size + exits.size + scores.size + initGame.size + shutdownGame.size + lol.size + serverLogs.size}"
  end

end