require 'test_helper'

class GameTest < ActiveSupport::TestCase
  context "A game report" do
    setup do
      @game = FactoryBot.create(:game)
      # @player1 = FactoryBot.create(:player, game: @game)
      # @player2 = FactoryBot.create(:player, game: @game)
      # @player3 = FactoryBot.create(:player, game: @game)
      # @player1.kills << FactoryBot.create(:kill, killer: @player1, victim: @player2)
      # @player1.kills << FactoryBot.create(:kill, killer: @player1, victim: @player3)
      # @player2.kills << FactoryBot.create(:kill, killer: @player2, victim: @player3)
    end

    it "report the game name" do
      assert_equal @game.name, @game.report[:name]
    end

    # it "report the total number of kills" do
    #   assert_equal 3, @game.report[:total_kills]
    # end

    # it "report the players" do
    #   assert_equal [@player1.name, @player2.name, @player3.name], @game.report[:players]
    # end

    # it "report the kills by player" do
    #   assert_equal({ "#{@player1.name}" => 2, "#{@player2.name}" => 1, "#{@player3.name}" => 1 }, @game.report[:kills])
    # end

    # it "report the kills by means" do
    #   assert_equal({ "headshot" => 1, "shotgun" => 1 }, @game.kills_by_means)
    # end
  end
end