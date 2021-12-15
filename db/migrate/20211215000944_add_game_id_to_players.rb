class AddGameIdToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_reference :players, :game, index: true
  end
end
