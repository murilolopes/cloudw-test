require 'test_helper'

class GameTest < ActiveSupport::TestCase
  setup do
    @game = FactoryBot.create(:game, name: "Infinity Pay Game")
    player1 = FactoryBot.create(:player, name: "Thiago", game_id: @game.id)
    player2 = FactoryBot.create(:player, name: "Scalone", game_id: @game.id)
    player3 = FactoryBot.create(:player, name: "Murilo", game_id: @game.id)
    FactoryBot.create(:death, assassin_id: player1.id, victim_id: player2.id, game_id: @game.id)
    FactoryBot.create(:death, assassin_id: player1.id, victim_id: player3.id, game_id: @game.id)
    FactoryBot.create(:death, assassin_id: player2.id, victim_id: player3.id, game_id: @game.id)
    FactoryBot.create(:death, assassin_id: nil, victim_id: player2.id, game_id: @game.id)
    FactoryBot.create(:death, assassin_id: nil, victim_id: player2.id, game_id: @game.id, cause: "MOD_FALLING")
    FactoryBot.create(:death, assassin_id: nil, victim_id: player3.id, game_id: @game.id, cause: "MOD_FALLING")
  end

  context "should return" do
    setup do
      @report_response = {
        name: "Infinity Pay Game",
        total_kills: 6,
        players: ["Thiago", "Scalone", "Murilo"],
        kills: [
          {"Thiago": 2},
          {"Scalone": 1},
          {"Murilo": 0}
        ]
      }
    end

    it "report game" do
      assert_equal @game.report, @report_response
    end
  end

  context "should return" do
    setup do
      @report_response = [
        {"MOD_ROCKET": 4},
        {"MOD_FALLING": 2},
      ]
    end

    it "report kills_by_means" do
      assert_equal @game.kills_by_means, @report_response
    end
  end
end