require "test_helper"

class QuakeLogParserTest < ActionDispatch::IntegrationTest
  subject { QuakeLogParser.call(file) }

  context 'Log file for init game' do
    let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-initgame.log", "r") }
    before {
      DatabaseCleaner.clean
      subject
    }

    context 'should create a game' do
      it 'named Code Miner Server' do
        game = Game.last
        assert_equal(game.name, "Code Miner Server")
      end
    end

    context 'should not create a game' do
      let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-initgame-2.log", "r") }

      it 'named Code Miner Server' do
        game = Game.last
        assert_equal(game, nil)
      end
    end

    context 'should create just two games' do
      let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-initgame-1.log", "r") }

      it 'named Code Miner Server' do
        first_game = Game.first
        last_game = Game.last

        assert_equal(first_game.name, "Code Miner Server")
        assert_equal(last_game.name, "Code Miner Server")
        assert_equal(Game.count, 2)
      end
    end
  end

  context 'Log file for connect player' do
    let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-connectplayer.log", "r") }
    before {
      DatabaseCleaner.clean
      subject
    }

    context 'when game was initiated' do
      context 'should create a player' do
        it 'with code 2' do
          assert_equal(Player.last.code, 2)
        end
      end

      context 'should not create a player' do
        let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-connectplayer-1.log", "r") }

        it 'with code 2' do
          assert_equal(Player.count, 0)
        end
      end
    end

    context 'when game was not initiated' do
      context 'should not create a player' do
        let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-connectplayer-2.log", "r") }

        it 'with code 2' do
          assert_equal(Player.count, 0)
        end
      end
    end
  end

  context 'Log file for changing player info' do
    let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-changeplayer.log", "r") }
    before {
      DatabaseCleaner.clean
      subject
    }

    context 'when game was initiated' do
      context 'should udpate a created player where code is 2' do
        it 'with name Isgalamido' do
          assert_equal(Player.find_by(code: 2).name, "Isgalamido")
        end
      end

      context 'should not find player' do
        let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-changeplayer-1.log", "r") }

        it 'where code is 2' do
          assert_equal(Player.find_by(code: 2), nil)
        end
      end
    end
  end

  context 'Log file for add player kills info' do
    let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-kills.log", "r") }
    before {
      DatabaseCleaner.clean
      subject
    }

    context 'when game was initiated' do
      context 'player where code is 3 should kill' do
        it 'player where code is 2 once' do
          victim = Player.find_by(code: 2)
          assassin = Player.find_by(code: 3)

          assert_equal(assassin.kills.count, 1)
          assert_equal(victim.deaths.where(assassin_id: assassin).count, 1)
        end
      end

      context 'world should kill' do
        it 'player where code is 2 and once' do
          player_2 = Player.find_by(code: 2)
          player_4 = Player.find_by(code: 4)

          assert_equal(Death.where(assassin_id: nil).count, 2)
        end
      end
    end
  end

  context 'Log file for end game' do
    let(:file) { File.open("#{Rails.root}/test/fixtures/files/qgames-kills.log", "r") }
    before {
      DatabaseCleaner.clean
      subject
    }

    context 'when game was initiated' do
      context 'should close the game' do
        it 'and calculate games duration' do
          game = Game.find_by(name: "Code Miner Server")

          assert_equal(game.duration, 107)
        end
      end
    end
  end
end
